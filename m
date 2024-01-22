Return-Path: <linux-kselftest+bounces-3369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCBB837567
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636931C25349
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2D482C3;
	Mon, 22 Jan 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GxM2tPBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4247F76
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959053; cv=none; b=MOKRjaH9Eu/+Lw1qfKapZjrCXapaD1f0VGlfdnlai7SYBSzUyKFzkpvH6h2Bvn5o2RchsLy7FsNG6H9P+44mN06VT225Iac/8CKgdgrVBmz5szM4tVBRaHHYQqv8KdXJj2PsT1nTocu7C99tJMYF5ZvrcKY7YKBw6bul9Lnng6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959053; c=relaxed/simple;
	bh=zoiLe0GmgV6XcV8qaxVsWn9xPRi07vWQTIaZGAPTy18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI3UmysWVr47mXmID9niklXX8f/f5dJ/uUh4v7XsUyforTYkl8Z9XYHZ3sbfsi6z0Jw3mM+Jizs3bo9gs85HmZKpToQCqF2kceme3f4t/Eunacoo92S4eCjG5pnB+gBqDU0ys/xWGn8poG//0TTBgxYPrCeMaSlah2heJHggXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GxM2tPBt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso780380a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959052; x=1706563852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKEBr23rbJKu9h7vL24E+EIJQpc/iOsyibRTRHA5Xcc=;
        b=GxM2tPBt1t3JBPCQCGXTtAnCdO9Ldc417Kde0DIbbhgYphNRBBiKN9zbbCXz77D7is
         vu18prh4YboCsJTBQ6b6viJp2JevCfRUkbre9TgwaRSGPW4Hy0n9iENFSYJjj/Xnu3/4
         KLp5uwlGwslDkrb2Y8a6FEy2e2pIjdNY9Rs+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959052; x=1706563852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKEBr23rbJKu9h7vL24E+EIJQpc/iOsyibRTRHA5Xcc=;
        b=BdkHRlDP07aaxqW4EEySUhNxDQQtUAeQCTrSvhTVnLUTZAWbTCzKtphnscaSyZn0BG
         43w/K1MfypcYeDGUsnvXDbuKSX09tmJoTAzkgbU6gCJifrukeszB3qXry6rtfGxjTrlw
         phv6SaFuoyMcZyaon99MHyg8uEin/C+fGmnKatigtE0chghMzbhCXP0F/vQF5mksfVbK
         q9eaw4nYJIr+FWS+RSBX4toxqXLhABbeBErnY+H/x4wGHskfGh1rUAbVX2EU06DnnUaE
         W7EE3GAGB2pyB9DsC1bKpEHWkpO0fmGxgrNJPZLDxNc17OyAbeR67mXSGhGgCw3fQBbI
         HczA==
X-Gm-Message-State: AOJu0YwQpd0NwaRmTIsHQy7Ce6Il00LspeMtOLEEsZPm96cz+YTwZk70
	pEtP6vVcnYB3LztVAR8zvpHn6WaHvCSSHXwmbOkbWK8VG9wgKFtoBy4u4YCWxw==
X-Google-Smtp-Source: AGHT+IGuu8CRZ67T/sbZ33Kh3Gjp/4gDLn2p+VjWE9BT0X4ASe4DyFux9xBdjaYSy+LIQ61UuJTqIQ==
X-Received: by 2002:a17:90b:1093:b0:28f:f706:f276 with SMTP id gj19-20020a17090b109300b0028ff706f276mr2415921pjb.80.1705959051711;
        Mon, 22 Jan 2024 13:30:51 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090a409100b00290ae3bf8d7sm2167130pjg.21.2024.01.22.13.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:30:51 -0800 (PST)
Date: Mon, 22 Jan 2024 13:30:50 -0800
From: Kees Cook <keescook@chromium.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <202401221328.5E7A82C32@keescook>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240116152210.GA12342@redhat.com>
 <AS8P193MB128538BC3833E654F56DA801E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240117163739.GA32526@redhat.com>
 <AS8P193MB1285FDD902CC57C781AF2770E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285FDD902CC57C781AF2770E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>

On Mon, Jan 22, 2024 at 02:24:37PM +0100, Bernd Edlinger wrote:
> The main concern was when a set-suid program is executed by execve.
> Then it makes a difference if the current thread is traced before the
> execve or not.  That means if the current thread is already traced,
> the decision, which credentials will be used is different than otherwise.
> 
> So currently there are two possbilities, either the trace happens
> before the execve, and the suid-bit will be ignored, or the trace
> happens after the execve, but it is checked that the now potentially
> more privileged credentials allow the tracer to proceed.
> 
> With this patch we will have a third prossibility, that is in order
> to avoid the possible dead-lock we allow the suid-bit to take effect,
> but only if the tracer's privileges allow both to attach the current
> credentials and the new credentials.  But I would only do that as
> a last resort, to avoid the possible dead-lock, and not unless a dead-lock
> is really expected to happen.

Instead of doing this special cred check (which I am worried could
become fragile -- I'd prefer all privilege checks happen in the same
place and in the same way...), could we just fail the ptrace_attach of
the execve?

-- 
Kees Cook

