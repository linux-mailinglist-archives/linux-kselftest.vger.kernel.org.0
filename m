Return-Path: <linux-kselftest+bounces-35597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E8AE349F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 07:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD416A3C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A41C8601;
	Mon, 23 Jun 2025 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z7faGWd3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD378F6E;
	Mon, 23 Jun 2025 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655647; cv=none; b=gaLeT6VLM1eXsTjyo0xhlj6ndtlpULcVbZ28fCbJhGTpTeoqkFoQ4mp3s3kaO7zacsbM+3tg6I99tdjtezmIHHqFYqrKq8vbeYJRPhF5h9sAV9832czucw2rZZ2nfa+Nuf1qyIlD+c2HpQMAhy09w3d7BO8m7Z5tOoOVZZWBQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655647; c=relaxed/simple;
	bh=FT8uGqxVW6mrmGie6HEzAshkdJ3LpUditiOBxPC4H4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skD/TQXm0dHLjvrcxFvXFMKOSVFbP2uzT3FrzuOHo7T/y3zt5H2oQ/DJZXJ/KhBSbQumLdJz319eEQeljGmuDmHURcpQ8+0S8nadC4Up0fXIRfb5FdI4X0r/z0VsxZ/deoV/3Qav37ogGGaBMEypXUm5jKwrGvX7JoyDlg1MR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z7faGWd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD2BC4CEED;
	Mon, 23 Jun 2025 05:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750655646;
	bh=FT8uGqxVW6mrmGie6HEzAshkdJ3LpUditiOBxPC4H4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7faGWd3RGu2OYH++LLbSxPHdP8u6o0vZDp+wg2hiYww2MZqgsC2M4H2V0G82SezV
	 sYxikT3atQoQc3DB9s8Zg2caVUI/83+SiQKN8arbjNQWfOiM2LY5MvQPmivScxpXbI
	 pClmSejGNywNHuL/en81EEEIuBKOTwJsFt1Rfs5k=
Date: Mon, 23 Jun 2025 07:13:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xandfury@gmail.com
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	selinux@vger.kernel.org, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] selinux: add capability checks for TIOCSTI ioctl
Message-ID: <2025062327-shady-broadcast-237d@gregkh>
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
 <20250622-toicsti-bug-v1-2-f374373b04b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622-toicsti-bug-v1-2-f374373b04b2@gmail.com>

On Sun, Jun 22, 2025 at 07:41:08PM -0600, Abhinav Saxena via B4 Relay wrote:
> From: Abhinav Saxena <xandfury@gmail.com>
> 
> The TIOCSTI ioctl currently only checks the current process's
> credentials, creating a TOCTOU vulnerability where an unprivileged
> process can open a TTY fd and pass it to a privileged process via
> SCM_RIGHTS.

If a priviliged process has a fd, what is the problem with it using this
ioctl in the firstplace?

> 
> Fix by requiring BOTH the file opener (file->f_cred) AND the current
> process to have CAP_SYS_ADMIN. This prevents privilege escalation
> while ensuring legitimate use cases continue to work.
> 
> Link: https://github.com/KSPP/linux/issues/156
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  security/selinux/hooks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 595ceb314aeb..a628551873ab 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3847,6 +3847,12 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>  					    CAP_OPT_NONE, true);
>  		break;
>  
> +	case TIOCSTI:
> +		if (!file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN) ||
> +		    !capable(CAP_SYS_ADMIN))
> +			error = -EPERM;
> +		break;

Are you sure this type of policy should be in the selinux core code?
Wouldn't you need a "rule" for selinux to follow (or not follow) for
this type of thing and not just a blanket change to the logic?

Also, have you looked at what userspace tools actually use this ioctl to
see if this change would break anything?

thanks,

greg k-h

