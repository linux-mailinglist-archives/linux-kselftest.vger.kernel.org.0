Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8679D147D9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbgAXKB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 05:01:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42567 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733077AbgAXKB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 05:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579860118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMJRKqMk2D6RalzmkNddIEyqjvW23GFO/6wjGDDka/U=;
        b=hFHNcdELgWpet0E1ObeDWznH/WaTAwepa0+3pH6YTSb+sv0NDm92RY3JM7y6lIN5ew/WNl
        QHPnWFv4LXcoYvB0ulzOYgeGtIhVPXS0fMjZzOiaBjkkQ+UbsLQopVExX7nhVS2WpD6/UY
        9TlYN3XtNo/GEaUbHRvsrq2fqB1Ky2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-a1tmzfSVNUKLmQfftrL5aw-1; Fri, 24 Jan 2020 05:01:56 -0500
X-MC-Unique: a1tmzfSVNUKLmQfftrL5aw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE0F21882CC7;
        Fri, 24 Jan 2020 10:01:54 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AC9260BE1;
        Fri, 24 Jan 2020 10:01:50 +0000 (UTC)
Date:   Fri, 24 Jan 2020 11:01:47 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 04/10] KVM: selftests: Add memory size parameter to
 the demand paging test
Message-ID: <20200124100147.p5tlpsgu6phauygv@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-5-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123180436.99487-5-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> new file mode 100644
> index 0000000000000..706e0f963a44b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * tools/testing/selftests/kvm/lib/test_util.c
> + *
> + * Copyright (C) 2020, Google LLC.
> + */
> +
> +#include "test_util.h"
> +
> +#include <ctype.h>
> +
> +/*
> + * Parses "[0-9]+[kmgt]?".
> + */
> +size_t parse_size(const char *size)
> +{
> +	size_t len = strlen(size);
> +	size_t i;
> +	size_t scale_shift = 0;
> +	size_t base;
> +
> +	TEST_ASSERT(len > 0, "Need at least 1 digit in '%s'", size);
> +
> +	/* Find the first letter in the string, indicating scale. */
> +	for (i = 0; i < len; i++) {
> +		if (!isdigit(size[i])) {
> +			TEST_ASSERT(i > 0, "Need at least 1 digit in '%s'",
> +				    size);
> +			TEST_ASSERT(i == len - 1,
> +				    "Expected letter at the end in '%s'.",
> +				    size);
> +			switch (tolower(size[i])) {
> +			case 't':
> +				scale_shift = 40;
> +				break;
> +			case 'g':
> +				scale_shift = 30;
> +				break;
> +			case 'm':
> +				scale_shift = 20;
> +				break;
> +			case 'k':
> +				scale_shift = 10;
> +				break;
> +			default:
> +				TEST_ASSERT(false, "Unknown size letter %c",
> +					    size[i]);
> +			}
> +		}
> +	}
> +
> +	TEST_ASSERT(scale_shift < 8 * sizeof(size_t),
> +		    "Overflow parsing scale!");
> +
> +	base = atoi(size);

I'd use strtoull(size, NULL, 0), allowing the user to input full 0x...
sizes too. And, if the strtoull is done before the scale parsing, then
you could supply a non-null endptr and avoid the need for the for loop.

Thanks,
drew

