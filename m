Return-Path: <linux-kselftest+bounces-17529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1402971E8A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69851B2297C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B645A58ABF;
	Mon,  9 Sep 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bOIXjvAE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096842AAB;
	Mon,  9 Sep 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897461; cv=none; b=OIjnTCE1bOutrAMHPJyeVtEKXTD/JXHtLNjJCTAQRF67QuwgE9W9RCtQi4zldxQE1VOaKg8+AZZQ+k1TX4Bkk8G/mJH/6Qp7uRN5Qh77wC6dxuyvL0YSh36VoHCAcAYO8TG2jHncyEgxTtGoVAuTerjDlyt2X0hZcS2tRStlE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897461; c=relaxed/simple;
	bh=oacz5eggXwzY8M8S+vaeXmwUAnxLro5Rgw36NkVBL04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc4FkrrnIem7KiF9FMh3Lna0eNetvNputn8S8CNHbMFDFlktRuM5nyG52MVwWYgPcBmfZat/vh+59CeCFeXYWfbgR38PF1C4f2YybP+6lGNPiczDPwkLf2Q0zFgtjPauOCOciZDq1aMnmHrddUhEt1FjGOxwbeii5yq0alNcBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bOIXjvAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2F1C4CEC8;
	Mon,  9 Sep 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bOIXjvAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725897452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbWr4vi9pa8+Cqp83onNnmk1v5W+k1MGPgiQ/1MwNSc=;
	b=bOIXjvAESpiyWOLfxiXwIhAtPOG1y1+0opyH9Q87ZwFnbiPRA4b3wNogUcxJqtsfJjafy2
	EIPyfn290ab/wumQZS8/Njm/fN604qRqGzCtPRB3Oi6XyRiwcddBL2PngABSxf1zQ6eimS
	KerTR+BY/Q0Rag++udJH9dHwTPIZMJ8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 242879eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 15:57:32 +0000 (UTC)
Date: Mon, 9 Sep 2024 17:57:31 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH RESEND v2 00/19] random: Resolve circular include
 dependency and include <linux/percpu.h>
Message-ID: <Zt8a6_RwLG2pEnZ6@zx2c4.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>

Hi Uros,

On Mon, Sep 09, 2024 at 09:53:43AM +0200, Uros Bizjak wrote:
> a) Substitutes the inclusion of <linux/random.h> with the
> inclusion of <linux/prandom.h> where needed (patches 1 - 17).
> 
> b) Removes legacy inclusion of <linux/prandom.h> from
> <linux/random.h> (patch 18).
> 
> c) Includes <linux/percpu.h> in <linux/prandom.h> (patch 19).
 
Thanks for doing this. That seems like a fine initiative to me. (I'm
also curious about the future percpu changes you've got planned.)

Tree-wise, were you expecting me to take this through random.git? And if
so, what timeframe did you have in mind? For 6.12 next week (can you
poke folks for acks in time?), or punt it for 6.13? Or did you have a
different tree in mind for treewide changes (in which case, I'll send
you an ack for the [p]random.h changes).

Regards,
Jason

