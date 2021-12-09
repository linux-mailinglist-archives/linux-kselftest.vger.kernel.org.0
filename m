Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5C46E93E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 14:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhLINmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 08:42:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40038 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbhLINmz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 08:42:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 212E3B82410
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 13:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A02C004DD;
        Thu,  9 Dec 2021 13:39:17 +0000 (UTC)
Date:   Thu, 9 Dec 2021 13:39:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 05/37] kselftest/arm64: Allow signal tests to trigger
 from a function
Message-ID: <YbIHAjP8jOcZbNxo@arm.com>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-6-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115152835.3212149-6-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 15, 2021 at 03:28:03PM +0000, Mark Brown wrote:
> Currently we have the facility to specify custom code to trigger a signal
> but none of the tests use it and for some reason the framework requires us
> to also specify a signal to send as a trigger in order to make use of a
> custom trigger. This doesn't seem to make much sense, instead allow the
> use of a custom trigger function without specifying a signal to inject.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/signal/test_signals_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> index 22722abc9dfa..8bb12be87a51 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> @@ -310,7 +310,7 @@ int test_setup(struct tdescr *td)
>  
>  int test_run(struct tdescr *td)
>  {
> -	if (td->sig_trig) {
> +	if (td->sig_trig || td->trigger) {
>  		if (td->trigger)
>  			return td->trigger(td);
>  		else

I think we can write this with even less indentation:

int test_run(struct tdescr *td)
{
	if (td->trigger)
		return td->trigger(td);
	else if (td->sig_trig)
		return default_trigger(td);
	return td->run(td, NULL, NULL);
}

-- 
Catalin
