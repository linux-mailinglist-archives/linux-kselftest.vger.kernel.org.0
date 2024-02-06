Return-Path: <linux-kselftest+bounces-4193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4A84B684
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 14:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F1E1C24138
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77634131721;
	Tue,  6 Feb 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3cDTcYy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2D130AC6;
	Tue,  6 Feb 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226559; cv=none; b=kcveqO6Ppvt6oaN+zLNi38GGZgit9G+4UzjjuNqiQtqc8xSt6rw35+WqYoZj/RxpS0u+SJEfTJepSBzGDg/v31FdnJsBm0LeEgkLkNfK63iDVvEn+hiZq/G4oCz5OVPyp5LInaCcJwVkOvK986l7T5QsTRVhDqdcerhXRjah0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226559; c=relaxed/simple;
	bh=iWakEVCeamLbWCgOLWghGshYAgpA8eUaGk2EafVrC0E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XEmuQnGv5ARJV0BoSOGfHgXUUgondHyI/QBXfANiT4HAS1KKnH88Ry/sI0zsofFR/sNGM0Sfu+6Lglub49xy/W6WO7Lrb2hdEJS0kCYcsk3fXAOz2XW697TwkYgNg0GMFNf22eBTeAOhXUIuzOo5Pw4128yCiH80fugROe+d2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3cDTcYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44E6C433C7;
	Tue,  6 Feb 2024 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707226558;
	bh=iWakEVCeamLbWCgOLWghGshYAgpA8eUaGk2EafVrC0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s3cDTcYyicFbRwm7P9z8FbEIolPeJQSGSE495GVaHlqnfJp3eDld81zzthohl+hko
	 24BQZ51sQOkgEQuBwlTMR2QDixnFzHnws4ZX4RlIWsmIc13pIvAt2bT7v25PcNV4bV
	 CWTkv0MA/djg9/DB5M3U6i87kGL5LwRA3djl7gNewBz3mNMde1TWzgrCYqmHRhspfv
	 rbBajhCrQI+S987PxF3D2S9E+G3MQttkFsrWL7+gJwm+tQF0LS0N9Iqkkkj/NRpWSP
	 Fa3HJyT8hhAI1up2a8w1l94ZYhvMbeDoDEW7/Doz7vNnVEWx8cQrdAjCJE0diXwuTN
	 ymHC7vFRRIWsg==
Date: Tue, 6 Feb 2024 22:35:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ali Zahraee <ahzahraee@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: ftrace: fix typo in test report
Message-Id: <20240206223554.719c004c6fe2f6c44aa81ef9@kernel.org>
In-Reply-To: <20240201082557.15965-1-ahzahraee@gmail.com>
References: <20240201082557.15965-1-ahzahraee@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 09:25:57 +0100
Ali Zahraee <ahzahraee@gmail.com> wrote:

> This is just another trivial typo fix. The typo shows up in the final
> report after tests are done.
> 

Thanks, and that is already reported very recently.

https://lore.kernel.org/all/20240129162841.57979-1-five231003@gmail.com/

> Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index c778d4dcc17e..25d4e0fca385 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -504,7 +504,7 @@ prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
>  if [ "$KTAP" = "1" ]; then
>    echo -n "# Totals:"
>    echo -n " pass:"`echo $PASSED_CASES | wc -w`
> -  echo -n " faii:"`echo $FAILED_CASES | wc -w`
> +  echo -n " fail:"`echo $FAILED_CASES | wc -w`
>    echo -n " xfail:"`echo $XFAILED_CASES | wc -w`
>    echo -n " xpass:0"
>    echo -n " skip:"`echo $UNTESTED_CASES $UNSUPPORTED_CASES | wc -w`
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

