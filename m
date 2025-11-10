Return-Path: <linux-kselftest+bounces-45215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F4FC46154
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EEF1890D33
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8614212B2F;
	Mon, 10 Nov 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTcqSOx7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2624BC07
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772303; cv=none; b=dh8JncsycZsbTkomzFjw3P824twKPUpTLnfUDKEBtsvCdPLL+raDvXbbqfDcmCkaZ5lNgSotjDmIbPsJjz9TGHFupjegpGxww6XuUFwiZl6i2GTJNdQwYRa+6Fhv3CCRjI9rDIJutJ3pt9ukJsLMAw8FzURtO1HszsSudgFAVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772303; c=relaxed/simple;
	bh=2U4KaUAelMziEmY2ShfzM/dox45MOEZL+6xWWn9Wxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVP/pTwZpUHlaks5InS/vl6BO82eWMldepd5hawzuyHfvO6yxBP0rNOzoh/JuK53EglAiRgkGIoyDO8TIYte83yH9rf0lHLj5jEpBE/y8DL2nzNXV/xSKcA+VBKP9HPD13JQUp8pzkEp2ybJzYVCnqsRb7KxbZ4F112dPEm3KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTcqSOx7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3761e5287c9so25068381fa.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 02:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762772300; x=1763377100; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cQtUBYgJJUDzd/kGspKY/MZmhkbZxSeoEQPwDEqgRs=;
        b=NTcqSOx7ig9H2EIc158DWbLgS07sNYRKpJfCyIdI4ilhKtbi3USxe7AusiqhwLy/lz
         s9IoLfSktAalSXpMeDil/3umKjgSx13p66KaU6kMidfBkpF0Tpdy6Q3WN5/H0ZWcqBpj
         eV7okqZsfqxG3qI5031IOur+LbphMQzKbw3I4SwwT8rPmMdWiu5yxZxmbM2RtZ24ljY6
         pLerxSAmTuKINtn8SY7iOWpOFoABU8ZJs4FPJL8xE/fS1kj5UWZjHdqZmj4tMotWe/5T
         PM3FzRxkGiHp1ucmmNV7VoJ+OqqFZ48eFc7c+ZYzM5T95gJdzL779itiMaCqaMlnVu+5
         BW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772300; x=1763377100;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5cQtUBYgJJUDzd/kGspKY/MZmhkbZxSeoEQPwDEqgRs=;
        b=pU3+2R43BK7hCOBrB6HiJxPOtFldQTwpzjjB4bgbMbDr4oyyNO7BhxsmB2sdxvf4Ca
         R04ETlVXhBpZB66np5sE2J6b7YIdgCTLuubopzH5v2pUWFoksOdTiRQ/be+l2Mt5nfFW
         /1vALMzqhE0Gxm4B9USWL0oexeB93EI8oj/PpEEh8uJVb7tgbwLGKDatcwN1120PGPtM
         I2RJgMBKU6sAlw/bIyHvFht6CW+tMFNF1agui5emXCP+x2gY+oiHr267Nqd7TdlsZG7w
         WgZmyEqvRBvruz0pTyrZSZII+G9m2duadoEbZW8Lt0/FFroPyr+WUSmZ5bsqu83pTbdZ
         8UiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbHfRKMvprwR7OC7d2jrsiA68LmvLHfiltrAnQHOsV2QDCpB546/+jGGxDhG9U3BrB8p4rqTI/V1seqEQVLO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQ3eY+WAuiI7oaQDXGnd4v6SnncmPTRaw+/gi0nUPhLN0ZCoe
	4I1Bd7+MJIAjsciYW9QzJEWefCGGhJzhNPLLTi0eSB2hljFpbqZS7WSe
X-Gm-Gg: ASbGncuxzq5G97VwYMJMr4lv9h9bf2jBmp6cxKa1mOaAsAdEGlXJCdxozqCAGCgs6N6
	1L6zXL8pVgF3IgToBnTWWwxrmWms+JuLy62inmIFb2QcffYcaf6bG4UiqD4MekytIRAyAbw+eXi
	WhMz296Jtx864K58BgiZOnJO33PE0Hv/RoYrLl36IYZ/IebtWYE4kSGZGHGfJftsSILgpfqbRT6
	iHuJuH4WAADVQGwWKl64iJ/tm4l2aKHew15/GIQnEbWZ4mYJfJGwkKAwJZjpPEOqQu1Y3RmLBTN
	95CpZgU2Sx1fymOcXI1FTtv76oPrxR2JXfWx/1cmZyXaL+BwzHhIOpUtSeiBnzIEJkivsMFTjZw
	8WSz34qnCCCH3PGjc6q+QIkraJEPsER2MIy99UfiOrp59GBijyjIyChwcFzuj0iHkTGZs/qkaiI
	e0YuuiHEuEwlKd
X-Google-Smtp-Source: AGHT+IF7uc05YKR1RuoI0CoWlX07D9z81TzLgbg2o88xiS2GWX+oFbp3ZEM1dvWDPFPIbk1p56pL9Q==
X-Received: by 2002:a2e:7206:0:b0:378:df5b:fbac with SMTP id 38308e7fff4ca-37a7b30c374mr15069891fa.38.1762772299942;
        Mon, 10 Nov 2025 02:58:19 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0ee40csm34451431fa.43.2025.11.10.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:58:19 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 691DA5A0033; Mon, 10 Nov 2025 13:58:18 +0300 (MSK)
Date: Mon, 10 Nov 2025 13:58:18 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] exec: don't wait for zombie threads with
 cred_guard_mutex held
Message-ID: <aRHFSrTxYSOkFic7@grain>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
 <aRDMNWx-69fL_gf-@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDMNWx-69fL_gf-@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Sun, Nov 09, 2025 at 06:15:33PM +0100, Oleg Nesterov wrote:
..
> static int kill_sub_threads(struct task_struct *tsk)
> {
>  	struct signal_struct *sig = tsk->signal;
> 	int err = -EINTR;
> 
> 	read_lock(&tasklist_lock);
> 	spin_lock_irq(&tsk->sighand->siglock);
> 	if (!((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task)) {
> 		sig->group_exec_task = tsk;
> 		sig->notify_count = -zap_other_threads(tsk);

Hi Oleg! I somehow manage to miss a moment -- why negative result here?

> 		err = 0;
> 	}
> 	spin_unlock_irq(&tsk->sighand->siglock);
> 	read_unlock(&tasklist_lock);
> 
> 	return err;
> }

p.s. i've dropped long CC but left ML intact)

	Cyrill

