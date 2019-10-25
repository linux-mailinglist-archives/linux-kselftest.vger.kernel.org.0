Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC2E4EB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2019 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfJYOOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Oct 2019 10:14:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24859 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729132AbfJYOOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Oct 2019 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572012858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhDkBYOFq3jbygFGSDnq7Gmuiq8UNYdSN3p8z01Ac/4=;
        b=eC3yRupqpQIzsFg66+vgkedON5sB21NSr31aOAru3hVmlCqf7zaGLC+76Qzhua63zNQkr4
        XF8lBw+cWqkBrbJZR60RD5l624B2T0TSQaSLcZKbltXdcj4NIlCYXKh0MZTmznuNvpl5ph
        Ktv2xLbriGmWWA0ulA03h7mPv62rnXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-z-_ddz5kOFS9YuvQA4lyKw-1; Fri, 25 Oct 2019 10:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1071F1005509;
        Fri, 25 Oct 2019 14:14:14 +0000 (UTC)
Received: from redhat.com (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36BEE60852;
        Fri, 25 Oct 2019 14:14:13 +0000 (UTC)
Date:   Fri, 25 Oct 2019 10:14:11 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: Disable the timeout
Message-ID: <20191025141411.GA17156@redhat.com>
References: <20191025115041.23186-1-mbenes@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191025115041.23186-1-mbenes@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: z-_ddz5kOFS9YuvQA4lyKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 25, 2019 at 01:50:41PM +0200, Miroslav Benes wrote:
> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test") introduced a timeout per test. Livepatch tests could
> run longer than 45 seconds, especially on slower machines. They do not
> hang and they detect if something goes awry with internal accounting.
>=20
> Better than looking for an arbitrary value, just disable the timeout for
> livepatch selftests.
>=20
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  tools/testing/selftests/livepatch/settings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/livepatch/settings
>=20
> diff --git a/tools/testing/selftests/livepatch/settings b/tools/testing/s=
elftests/livepatch/settings
> new file mode 100644
> index 000000000000..e7b9417537fb
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/settings
> @@ -0,0 +1 @@
> +timeout=3D0
> --=20
> 2.23.0
>=20

Yes, disabling the timeout for our tests makes sense since they already
have internal checking.  Tested this in a VM and looks good to me,
thanks.

Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe

