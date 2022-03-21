Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C14E2D71
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 17:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350434AbiCUQL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 12:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350867AbiCUQLG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 12:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67C572B1A9
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647878955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfGTEmUWEu/FuJm8rv4KxXhPR+l0i9Uc8G4IxOhNPME=;
        b=RFRClreNsSebInBDn4kkb4KKcxyOEZ5S5eFLYOwBfeK1vySIOt97dLYRBB02lFYzOIY+8H
        WrfjD7IH5jUpt8mq6IZT0i4/JeQa5E67+R/0e50DZxlaAiL0ryA6iAp99e0ALX60eFpfby
        m1MfEW8OkKsmaxeBz/v4gDo3fK7rULY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-yB6jnd0MOL-GRtfmoIZGTQ-1; Mon, 21 Mar 2022 12:09:13 -0400
X-MC-Unique: yB6jnd0MOL-GRtfmoIZGTQ-1
Received: by mail-wm1-f70.google.com with SMTP id m35-20020a05600c3b2300b0038c90ef2dceso4741111wms.4
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 09:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=sfGTEmUWEu/FuJm8rv4KxXhPR+l0i9Uc8G4IxOhNPME=;
        b=kTQ4sGZCvYuw+c2xhuhYShpMc3UqZQ0rjfO00MX2CPzLR483/9XN40NtyVwaxmNBj5
         5ny0GaZAeMgUMEo5LvH4JG/8jtPgT/eFUV3TXMNIo7mTnM0EvcAADuiHjnZXUG9jTrNu
         iPQkHrsAXZ99fj7KbFqo16Q4MfjjQQvw2+CZdVpkfQGqiO2Ch9iMb8WrJl0hb5Zq9kNk
         U85z4j2WhyJUB6bSJdWacsQkOmFWsBNtq6wBzghSTbg2FjxlK0JQJ1tChmpDkY+9uhJg
         /rYooKtM/BA0/56seET48T5gFzdaNIqb2kcA5rtIlZ9apkX2Mr9GzlUYnxx64YnJxgtP
         kFuw==
X-Gm-Message-State: AOAM530bkl+8kIy4eku2r3jvxH3zBdDCCY8Or+rFI7IJORj/2idLHCI8
        PW6L22IDDx4CTubCEjLt2liEd4CbY780MwwEPpXWpf2a/HQMThHocTYrGBIvBrxSwfhW4hK4eWQ
        APX0cXIYhM+IvJkbTmF2rMr7KpZpj
X-Received: by 2002:adf:a4ce:0:b0:203:fce0:755e with SMTP id h14-20020adfa4ce000000b00203fce0755emr11044484wrb.510.1647878951692;
        Mon, 21 Mar 2022 09:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP8tnNpWfcqHVPmFM+7jTdPf3u8hsTPKsNtKPW9hZQPytRSq0aasePBoKmg+nUJ/TirjdyGQ==
X-Received: by 2002:adf:a4ce:0:b0:203:fce0:755e with SMTP id h14-20020adfa4ce000000b00203fce0755emr11044467wrb.510.1647878951397;
        Mon, 21 Mar 2022 09:09:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm14376699wmh.31.2022.03.21.09.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:09:10 -0700 (PDT)
Message-ID: <51635f15-0f43-0f9d-e66f-9cd651431f81@redhat.com>
Date:   Mon, 21 Mar 2022 17:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH V5 1/2] selftests: vm: bring common functions to a new
 file
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20220317103323.94799-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220317103323.94799-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
> new file mode 100644
> index 0000000000000..e9f5a0f2be196
> --- /dev/null
> +++ b/tools/testing/selftests/vm/vm_util.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include "../kselftest.h"

Are that latter two really required in this header? IMHO they should be
moved to the respective files that need them.

If you return "bool" below, you might want to include <stdbool.h> here
as well.

> +
> +uint64_t pagemap_get_entry(int fd, char *start);
> +bool pagemap_is_softdirty(int fd, char *start);
> +void clear_softdirty(void);
> +uint64_t read_pmd_pagesize(void);
> +uint64_t check_huge(void *addr);

Apart from that, LGTM.

-- 
Thanks,

David / dhildenb

