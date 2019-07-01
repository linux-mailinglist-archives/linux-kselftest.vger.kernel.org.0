Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6515BCA0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfGANMy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 09:12:54 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:60889 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANMy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 09:12:54 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 67D032035D;
        Mon,  1 Jul 2019 15:12:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1561986767; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9t9pBivaBS8etNTZ6qCGnieNPfZCLTos1wsuQiVM89M=;
        b=0V0eoBZL9Eb2zvugOYhC+QpYytevRxSId7mkpgf9xAUlUsTez+6ox6KH7i/87bPBx8R0q7
        6r/JWqkcDCk8hUL/wYJnmRHa1laeapmE57UABwudzarRgBWNqB2+PHavOq1Rb7b2SvjWyE
        IphI/XmIKwLPcXHdkibnGBqb9dweIx8d9DlrVmUYojWxOzmnrDXYoVu9xW86R8/A4SSvpp
        PSd+RoPPz5kjahiiLCLo6gapt9dZiP6dgF35b1iSgaZjvH9EkGPaJ7/LpL0SwaGmm3WDlP
        yHLz840yit2QYCvxxH01LE1BtVfy9t5+I0QioFAauRAnwI0pE94nmfC4WNxRZg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id C3CF7BEEBD;
        Mon,  1 Jul 2019 15:12:46 +0200 (CEST)
Message-ID: <5D1A06CE.6000405@bfs.de>
Date:   Mon, 01 Jul 2019 15:12:46 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests/x86: fix spelling mistake "FAILT" ->
 "FAIL"
References: <20190701130431.13391-1-colin.king@canonical.com>
In-Reply-To: <20190701130431.13391-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.10
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Am 01.07.2019 15:04, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an spelling mistake in an a test error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/x86/test_vsyscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 4602326b8f5b..a4f4d4cf22c3 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -451,7 +451,7 @@ static int test_vsys_x(void)
>  		printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
>  		       segv_err);
>  	} else {
> -		printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
> +		printf("[FAIL]\tExecution failed with the wrong error: #PF(0x%lx)\n",
>  		       segv_err);
>  		return 1;
>  	}


"wrong error" sounds like scratching table, perhaps "error" is here sufficient ?
Bomus points when user is expected to report this.

re,
 wh
