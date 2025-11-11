Return-Path: <linux-kselftest+bounces-45310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7C8C4D863
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BB23A4625
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFD34E75C;
	Tue, 11 Nov 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNMKetIT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36C256C8D;
	Tue, 11 Nov 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861949; cv=none; b=Cc5fz/tAupki/ul6QNtsvE+v7hNGyBivtpvPKBDvOM8xnPzIjUP1XlqNpVEQUbZ+2SxTsG7LiiTD8FPe1olv1COcRxhtyRkJyxNoMF8KCKjm4F2slApkgRU8bRcQ8mZfqGbY9i1pGiyhnE12XQzDCB42fFWnVYqi6GlZ/rIy/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861949; c=relaxed/simple;
	bh=7EWr3lLxkrG+MopAVeZM5w/ywBZTEz3erxdYhaDu5ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DolU6e2KbRfHzHtwF6CqGqu1c/5624LB3A1W+4Se1e5o2eFzz33vgWGwvdy1zvVjxjoDNWfML+pVr4ye4SOBtck+LPXUSL8OBkpxlM38icBee8TlSmdsmrRkZ+qNImDtcTe61mz61werLTu+rm7/Na8e/y8rsuauLiIviRNFwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNMKetIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB8AC4CEF5;
	Tue, 11 Nov 2025 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861949;
	bh=7EWr3lLxkrG+MopAVeZM5w/ywBZTEz3erxdYhaDu5ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNMKetITnIdI+xxdF/TA70hKOc2puba/EJVkuAHU4KEkcyHmBky9N/+8WHrn7hg7g
	 EjYI+3A9E38ph29vGpUK0/MQCK6Uy3dNqFUy6DwyTd9YKtG3SuFlBo7bLri0P1DEg+
	 9YWaZtitwhIXgzAk4MqX73z0jg1QuIVh/zbYIjk0IQaBPcxDcJmzYrWJg4cZdx3iTc
	 y2ra2Yle9WZyvGkur0WAzYQ3V7U1cZsU23NxLdrqYOIcKQfa9mD+ESswcaHyJ1ZvCt
	 gHQDvd/nmnKH7jyzdgbYYQuRAEt6APJvt1jcq1cr4Ij98MRKTr95TEg1UtR6ggUlcU
	 U4QxcPGfnqTXg==
Date: Tue, 11 Nov 2025 11:52:25 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 07/11] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <aRMjeZVqsnc1BNr-@horms.kernel.org>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>

On Thu, Nov 06, 2025 at 04:49:51PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add check_result() function to reuse logic for incrementing the
> pass/fail counters. This function will get used by different callers as
> we add different types of tests in future patches (namely, namespace and
> non-namespace tests will be called at different places, and re-use this
> function).
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v3:
> - increment cnt_total directly (no intermediary var) (Stefano)
> - pass arg to check_result() from caller, dont incidentally rely on
>   global (Stefano)
> - use new create_pidfile() introduce in v3 of earlier patch
> - continue with more disciplined variable quoting style
> ---
>  tools/testing/selftests/vsock/vmtest.sh | 95 +++++++++++++++++++++++++--------
>  1 file changed, 72 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 557f9a99a306..05cf370a3db4 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -46,6 +46,8 @@ readonly TEST_DESCS=(
>  	"Run vsock_test using the loopback transport in the VM."
>  )
>  
> +readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
> +
>  VERBOSE=0
>  
>  usage() {
> @@ -79,6 +81,28 @@ die() {
>  	exit "${KSFT_FAIL}"
>  }
>  
> +check_result() {
> +	local rc arg
> +
> +	rc=$1
> +	arg=$2
> +
> +	cnt_total=$(( cnt_total + 1 ))
> +
> +	if [[ ${rc} -eq $KSFT_PASS ]]; then
> +		cnt_pass=$(( cnt_pass + 1 ))
> +		echo "ok ${num} ${arg}"
> +	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
> +		cnt_skip=$(( cnt_skip + 1 ))
> +		echo "ok ${num} ${arg} # SKIP"
> +	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
> +		cnt_fail=$(( cnt_fail + 1 ))
> +		echo "not ok ${num} ${arg} # exit=$rc"

Hi Bobby,

Should num be cnt_total above?

> +	fi
> +
> +	cnt_total=$(( cnt_total + 1 ))

It seems that cnt_total is being incremented twice.
Once seems like it ought to be enough.

> +}
> +
>  vm_ssh() {
>  	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
>  	return $?

I'll confess that I didn't notice these myself, but
Claude Code with https://github.com/masoncl/review-prompts/ did.

