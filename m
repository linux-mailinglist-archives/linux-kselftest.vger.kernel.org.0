Return-Path: <linux-kselftest+bounces-19825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DA9A0435
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19661F26283
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F228F1D2211;
	Wed, 16 Oct 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJvzBjfp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0261C4A2B;
	Wed, 16 Oct 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067267; cv=none; b=hRtjGBwpaffNi/q5x3g/vxw79y5v8jv911qIP8OrhifasNI9EW5F1eZOH+Ah6DkIkH4E+x5JXOjAUZCxSy9xWlwJISJ4JaxBxoY7swduhJqRY61vNSQXz/FVXOD36SzrTyrXJ+FrN7WDSQAyjvxGu1BDidgCYup/shMJ/gri6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067267; c=relaxed/simple;
	bh=eGkXH+5ZzEEFVXEZDvjLnnvGw9VcqiFR+Pwn3/CYKao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MipkPtvE3wS/sdezT8+K3zKipHDGGNYc+Step415hj7sYiFm6hIqe7ndy4vC7Eiyj3omnE2nCFDo4NGapRaOwqvyYGo+R6jJFRwnV92+ZEDFQZ4DCvQKzb+Lfhsf24Qw3BDpNWG6xKyY65NHTOeJtADVbHekHphlnZztvTZyLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJvzBjfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3655BC4CEC5;
	Wed, 16 Oct 2024 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729067267;
	bh=eGkXH+5ZzEEFVXEZDvjLnnvGw9VcqiFR+Pwn3/CYKao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJvzBjfpszUPcRIBRdIQQKcaEUb+haDvqGrCNBtcQsXHanXKKV4ftK2NwD+GPqDor
	 JFRBDemZh8BhbrDSmr3TC8BY48lvRzIPpMBlbSeEz08QslwJC/d1ngyah+jqjZVI+z
	 9waVBHIQumujC/uDw8ZiDzfHIJDhLyhlvp5wb55t1igWIUspM6U20AieDzZuRWBlJv
	 eI3oK/zOBOyNS8hX7ezeWGvqe6O3QjBh7ySw4ZhmjtxPTI6g+e9mop2tVduiKDc7A1
	 j8PlGz8MVibW7sqo/Q0cyrXx/IQCQjjmHhCFfBfdQLlA+hrmafcFY9Dswjf5JmHgbO
	 JpK/uYHOgyLtA==
Date: Wed, 16 Oct 2024 10:27:43 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Yun Lu <luyun@kylinos.cn>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftest: hid: add the missing tests directory
Message-ID: <4ioshjncgxafin7jcm7kne5fahp4l5nhk5664mnrdo7fgutgyn@jac5gopdyjty>
References: <20241015091520.2431150-1-luyun@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015091520.2431150-1-luyun@kylinos.cn>

On Oct 15 2024, Yun Lu wrote:
> Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
> has added the run-hid-tools-tests.sh script for it to be installed, but
> I forgot to add the tests directory together.
> 
> If running the test case without the tests directory,  will results in
> the following error message:
> 
>     make -C tools/testing/selftests/ TARGETS=hid install \
> 	    INSTALL_PATH=$KSFT_INSTALL_PATH
>     cd $KSFT_INSTALL_PATH
>     ./run_kselftest.sh -t hid:hid-core.sh
> 
>   /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331: PluggyTeardownRaisedWarning: A plugin raised an exception during an old-style hookwrapper teardown.
>   Plugin: helpconfig, Hook: pytest_cmdline_parse
>   UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [...]
>   __main__.py: error: unrecognized arguments: --udevd
>     inifile: None
>     rootdir: /root/linux/kselftest_install/hid
> 
> In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
> directory to run tests. The tests directory also needs to be added to be
> installed.
> 
> v2: add the error message
> 
> Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Shuah, I guess you'll want to take this one through your tree given that
you already took the run-hid-tools-tests.sh one?

Cheers,
Benjamin

> ---
>  tools/testing/selftests/hid/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 38ae31bb07b5..662209f5fabc 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -18,6 +18,7 @@ TEST_PROGS += hid-usb_crash.sh
>  TEST_PROGS += hid-wacom.sh
>  
>  TEST_FILES := run-hid-tools-tests.sh
> +TEST_FILES += tests
>  
>  CXX ?= $(CROSS_COMPILE)g++
>  
> -- 
> 2.27.0
> 

