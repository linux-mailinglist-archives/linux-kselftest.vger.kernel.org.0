Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDD5E52DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2019 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfJYSAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Oct 2019 14:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbfJYSAU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Oct 2019 14:00:20 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD83721D7F;
        Fri, 25 Oct 2019 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572026419;
        bh=w6k37SmPZPh1bToZd3ldVpAwOET03tACIRG/OQf1rxk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bQt2Em5RCSV4ep1b7DWyUMc2QvMBVDIGS9b1ycG7hniWN17TvUfv0RhjhA+pdCpAo
         ajeHec60HphK8M2icrqm/74lo5GBLllMCCobsDSWU+TuIjT0bCRymILKhmWBiunUTP
         KhaMJHiD04Kcuqrh1zf3Yw98DU/ytwWtQPpLffII=
Date:   Fri, 25 Oct 2019 20:00:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
cc:     jpoimboe@redhat.com, pmladek@suse.com, joe.lawrence@redhat.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: Disable the timeout
In-Reply-To: <20191025115041.23186-1-mbenes@suse.cz>
Message-ID: <nycvar.YFH.7.76.1910251959550.13160@cbobk.fhfr.pm>
References: <20191025115041.23186-1-mbenes@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Oct 2019, Miroslav Benes wrote:

> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test") introduced a timeout per test. Livepatch tests could
> run longer than 45 seconds, especially on slower machines. They do not
> hang and they detect if something goes awry with internal accounting.
> 
> Better than looking for an arbitrary value, just disable the timeout for
> livepatch selftests.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  tools/testing/selftests/livepatch/settings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/livepatch/settings
> 
> diff --git a/tools/testing/selftests/livepatch/settings b/tools/testing/selftests/livepatch/settings
> new file mode 100644
> index 000000000000..e7b9417537fb
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/settings
> @@ -0,0 +1 @@
> +timeout=0

Pushed to livepatching.git#for-5.5/selftests. Thanks,

-- 
Jiri Kosina
SUSE Labs

