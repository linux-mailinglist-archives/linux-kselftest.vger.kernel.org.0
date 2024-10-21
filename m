Return-Path: <linux-kselftest+bounces-20245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B214E9A6032
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25C31C21742
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A291E3773;
	Mon, 21 Oct 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI3iwcA+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263E194C79;
	Mon, 21 Oct 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503290; cv=none; b=dEtPHgeENv23bHC3TvElMrNPByxU2eUYhCbIS0Jv0xiIRGubefUkTckNB0QsDS10bJZPC7oAdStKIYeN8jght/rluRCZe0O451pbVh1Cv8s56y0mG+oErzV7GtJ+iPL/aJgcW7AIInL1oizhyoBj7BeAYHTcnXSZR4PXcNcQTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503290; c=relaxed/simple;
	bh=5WqFv76qM4ugyABO6dLP+kIwg9Lncdqs6yKVuy54srA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBQsB68ZZYzlHL/p7UDOLBs01M2/jKOzOzhU+mJxN57cihYJd2FS+kNz7BKcgZ7v6JU8W6ud5panPWi1Rh8pa4TybaHyq5Bk0i2OCwWLHPsOu3ylZvN9QGcY19n9a02vE6x2faYCGOTENA7lTebfh+cY9yUIvB82KCnyzJKJEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI3iwcA+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so75576266b.3;
        Mon, 21 Oct 2024 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729503286; x=1730108086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/FjAzIQJ4B6zcRlVKwNhNL1pS7sRl/wzKTSA8WVDbOM=;
        b=lI3iwcA+ksAkaontZQamJYYG4MwTOoqQkqXgKAYiZw2nKgJJ0BM17T82lrYYDpjVUH
         tZUl3tlV8J5N1mTCfhdmzWojg/2LEIIw9dMzQoaxZJcSY+qaJXsUjpWHZTL4vYVPe8xL
         zyicAnZAqO9JS1M9VKd2+Atg23mvrnQr3x2748HpjTI+6a3NWPJrIln1JwXk6Q6NE19y
         5P8M7gKclcj0bjnFYsFohrHGD6N4kshRjxSkwxP0eP2U/ntZgRINymHhMX/QS6yU3ICi
         gh0VEYApZtBR3OmQl25B6/Y7vwn00YRpA+yP0F/EOkf2229dvhxm1Srd+20jExNO96RZ
         7lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503286; x=1730108086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FjAzIQJ4B6zcRlVKwNhNL1pS7sRl/wzKTSA8WVDbOM=;
        b=MGuJewrfs8JWsFnHA3R/HJpBZpywVeTABIsaXhMLvQgY+ID53I7yeHVbVhcC/dbfKA
         GcxkySYZIn85PhKB5wJ3fXYef6X+KfV/HKuElLwM6UhucMGZYBdf0QTDk1dA0NpCQ0Sn
         sW2j1+rgzQp63vCFx/T3ks/LI8JHnluRez1RdDH5cJDAcsbc/5vC/+Yr0f7zz6aBW/rA
         3hzjhsC6a7xX5pDaW1XGsShdgY2/s3htnhKPciYViFwTfgnyBCB/JMaf7ooFiC2SR/JP
         uq2XfMge/Wq4vk/3UrRojuQw+vxc7MRwGupQvWC7NTY21aIwMXscc4xDTlr5s7kWJgO+
         sASA==
X-Forwarded-Encrypted: i=1; AJvYcCWe/IDZTMp/hTC9qQV/6pMvjmK4I+WWqnM0lIHF7dwTPJ4tukcbrwyFEfvOTaHaVLnnT0Q=@vger.kernel.org, AJvYcCXdgRR2TQJDPLJd+l4DPlDJW14kBMlFpICekRDLzUBGQkLW7dLJc8OkJcOu/4W1RhCMAfTv2TR2kvBV+W5cFY3y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++EGISlRkt99Be+SW48mq8ukewFerItVDc7soVgbmtGdZm2SR
	JmtXwrpBiVzZx5i57G8MuluZUPMguBqf+GSTSUNIOcHz3uSWnkwu
X-Google-Smtp-Source: AGHT+IE0z9obeTqvXwKkLsAd3V+WleFbeXL7J0i0qYvl1lDxIyr/ZNYs+wK+DqQLpurrCKOjo+8JTA==
X-Received: by 2002:a05:6402:13c8:b0:5cb:728e:926b with SMTP id 4fb4d7f45d1cf-5cb728e9311mr2146008a12.17.1729503286215;
        Mon, 21 Oct 2024 02:34:46 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c7255esm1812592a12.80.2024.10.21.02.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:34:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 11:34:43 +0200
To: Jason Xing <kerneljasonxing@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH bpf-next v2] bpf: handle MADV_PAGEOUT error in
 uprobe_multi.c
Message-ID: <ZxYgM_YDoSJO1TxL@krava>
References: <20241021050706.29403-1-kerneljasonxing@gmail.com>
 <ZxYFn7fko5C9BnHe@krava>
 <CAL+tcoB-tHf5kW6Hq0TtsnqFLU3nWZEuZ+L7roDyJ0q_qW=WxA@mail.gmail.com>
 <CAL+tcoAw1WGnJs2DQjEyzsh_rNXKA44oYX5RvQi8nCvt4+ynLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAw1WGnJs2DQjEyzsh_rNXKA44oYX5RvQi8nCvt4+ynLQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 04:07:15PM +0800, Jason Xing wrote:
> On Mon, Oct 21, 2024 at 3:51 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 3:41 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 01:07:06PM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > When I compiled the tools/testing/selftests/bpf, the following error
> > > > pops out:
> > > > uprobe_multi.c: In function ‘trigger_uprobe’:
> > > > uprobe_multi.c:109:26: error: ‘MADV_PAGEOUT’ undeclared (first use in this function); did you mean ‘MADV_RANDOM’?
> > > >    madvise(addr, page_sz, MADV_PAGEOUT);
> > > >                           ^~~~~~~~~~~~
> > > >                           MADV_RANDOM
> > > >
> > > > Including the <linux/linux/mman.h> header file solves this compilation error.
> > >
> > > hi,
> > > strange, uprobe_multi.c even has:
> > >
> > > #ifndef MADV_PAGEOUT
> > > #define MADV_PAGEOUT 21
> > > #endif
> > >
> > > and '#include <sys/mman.h>' should be all that's needed
> > >
> > > could you please share more details (extra flags) on how you compile?
> >
> > OMG, thanks for reminding me. The net-next branch that I compiled
> > doesn't have those three lines. Now I can see them in bpf-next. So I
> > think the issue has been fixed already :)
> 
> Link is https://lore.kernel.org/bpf/d9846ceb-b758-4c17-82d1-e5504122a50a@oracle.com/
> 
> The previous comment is not that right. Making sure to include
> <sys/mman.h> first solves the issue so there are no complaints when
> compiling. No need to define MADV_PAGEOUT, I think.

right, but looks like it was not enough on Alan's setup [1]

jirka


[1] c27d8235ba97 selftests/bpf: Fix uprobe_multi compilation error

