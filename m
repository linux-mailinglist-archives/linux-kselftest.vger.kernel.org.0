Return-Path: <linux-kselftest+bounces-45108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF51C408A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 16:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FDB565682
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072F329E4C;
	Fri,  7 Nov 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqsNX+m5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E162D97A1;
	Fri,  7 Nov 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528110; cv=none; b=nrjfWRIfx/vB3BPQ7/VjbOSenj+o4xlS03rSv6sQfjQK0oIJuPauAqFPCDisWsQugvwQvyol9T5K41V5CQ/5NQDrU0T63+D3TmT7bRc6H0XhF5NALoaKRNevXM4SJy/xqgLDAvBl5dZee8khMIEZcnUpix1T8MR5ltXbKDy8/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528110; c=relaxed/simple;
	bh=zVlScliDqQsDY47IO1XDLSMlw/CwYu7yQCTHN10PDaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEZp02pZWCJRT0pmW75Yy/uhOVWX6L84GFEq/OZPlMYU3G3xI7Pl1w4FJAOqBafytMfMgmJnctz3VrHchnEokG8FIleLF9JD2Ln0jPr9B+SPaGKfVNoGmQlFk6Ypg5RnO2j9fMZwwrXjh54U/49VHOLZqOHryvVO9cZIfPoJX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqsNX+m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85F8C19424;
	Fri,  7 Nov 2025 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762528109;
	bh=zVlScliDqQsDY47IO1XDLSMlw/CwYu7yQCTHN10PDaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqsNX+m5K1ELsjAnLaoosxRhKQJOVGzRJgM+w9qy29kHURpRyriXFVcakZuhHpFox
	 gx42iqbZiI+X15fsyffxxDw4KGDCdj1t5IgVOZsRmvoJh9RFqXNWVnUGAzpu5Ge5rS
	 VbysVwTHdsOKJxSebh2UcvVsYYOCRlTF0hb8lqYK1NE/O/j7CLxoa2mQloDckAELar
	 TjTiTVz8n3UEVfL8DI6WKYb20i+WYpKGYGbGZfdZFBBbrZi8LCHnbocyCTyfIUEVLt
	 8eGHYugNFFWi71AJFR3l1cckrqbTkevY8Z220DNLzLiVkohJM4odVlrFZQ6UJKj3zA
	 zyNzqTj+7ccBQ==
Date: Fri, 7 Nov 2025 15:08:25 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 04/11] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQ4LaUi9wTnEN8KA@horms.kernel.org>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-4-519372e8a07b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-4-519372e8a07b@meta.com>

On Thu, Nov 06, 2025 at 04:49:48PM -0800, Bobby Eshleman wrote:

...

> @@ -90,15 +85,19 @@ vm_ssh() {
>  }
>  
>  cleanup() {
> -	if [[ -s "${QEMU_PIDFILE}" ]]; then
> -		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
> -	fi
> +	local pidfile
>  
> -	# If failure occurred during or before qemu start up, then we need
> -	# to clean this up ourselves.
> -	if [[ -e "${QEMU_PIDFILE}" ]]; then
> -		rm "${QEMU_PIDFILE}"
> -	fi
> +	for pidfile in "${PIDFILES[@]}"; do
> +		if [[ -s "${pidfile}" ]]; then
> +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> +		fi
> +
> +		# If failure occurred during or before qemu start up, then we need
> +		# to clean this up ourselves.
> +		if [[ -e "${pidfile}" ]]; then
> +			rm "${pidfile}"
> +		fi
> +	done
>  }

Hi Bobby,

This is completely untested, but it looks to me
like cleanup() could be implemented more succinctly like this.

cleanup() {
	terminate_pidfiles "${PIDFILES[@]}"
}

>  
>  check_args() {
> @@ -188,10 +187,35 @@ handle_build() {
>  	popd &>/dev/null
>  }
>  
> +create_pidfile() {
> +	local pidfile
> +
> +	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
> +	PIDFILES+=("${pidfile}")
> +
> +	echo "${pidfile}"
> +}
> +
> +terminate_pidfiles() {
> +	local pidfile
> +
> +	for pidfile in "$@"; do
> +		if [[ -s "${pidfile}" ]]; then
> +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> +		fi
> +
> +		if [[ -e "${pidfile}" ]]; then
> +			rm -f "${pidfile}"
> +		fi
> +	done

I think it would be useful to remove $pidfile from $PIDFILES.
This might be easier to implement if PIDFILES was an associative array.

> +}
> +

...

> @@ -498,7 +529,8 @@ handle_build
>  echo "1..${#ARGS[@]}"
>  
>  log_host "Booting up VM"
> -vm_start
> +pidfile="$(create_pidfile)"
> +vm_start "${pidfile}"
>  vm_wait_for_ssh
>  log_host "VM booted up"
>  

> @@ -522,6 +554,8 @@ for arg in "${ARGS[@]}"; do
>  	cnt_total=$(( cnt_total + 1 ))
>  done
>  
> +terminate_pidfiles "${pidfile}"

I am assuming that there will be more calls to terminate_pidfiles
in subsequent patch-sets.

Else I think terminate_pidfiles can be removed
and instead we can rely on cleanup().

> +
>  echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
>  echo "Log: ${LOG}"
>  
> 
> -- 
> 2.47.3
> 
> 

