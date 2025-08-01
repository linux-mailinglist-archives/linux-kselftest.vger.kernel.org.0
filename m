Return-Path: <linux-kselftest+bounces-38189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F20B1886D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 23:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1EB7A2276
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120E1E2858;
	Fri,  1 Aug 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG+F2fhn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF0199934;
	Fri,  1 Aug 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082038; cv=none; b=Ffltn9RiX0kYsQ++UoE4QCQuDGrzGPyqIw9Cl09uivYkzbTygz9EZHeoIrwXmKd2sLeMiKICd81mTBvT8gouh5evfnf9yIu2SYXMAnMsWj5fAEKyXUH0iieyAGmCZRxnPbFaPaeplHVimxgdbFMn7FizzaA1+nvqSgOJJmEUOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082038; c=relaxed/simple;
	bh=yCsxRMUQIxP548jpPiHUjuRjBaL7jboGbbDfPY0uh5s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iqEZCNbs2QAI+a4di8/6HFhTsm0pHKm46mMVyLadW7Q6/l9r4kCH0U2UEQrNYXv10f8GFHt/rjyvjxrUScF9VCukcpdUHuyuM6xYiKDTsXF635CwBL/7Wi9MNWLhm03XWEuzLS0PO3VJpPb+A90lvhPA7N3ffjezF3mWyEnVxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG+F2fhn; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7180bb37846so13608787b3.3;
        Fri, 01 Aug 2025 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754082036; x=1754686836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXiZrswsxQPUUeYFbRHdd6ObCCznOMCn+Fx47vEWLNM=;
        b=LG+F2fhntgo2wUohOxy3ATveFtLU1W7OrAT92PKysead044Xf+JHjySLegjs9oJimD
         INZK1NGDgAqjnUuscDPkiU/nRCjWAmGeR4bAlse+G5mKpD4tP/Cf2E+uix0So52ncILL
         e38yQY0tPlO7Ukn0EMeorltc37HjME6u1Ag/aE4PG9q1tk8D8dOCcdOr+QSSPrv080Dp
         6E725EzcOqX2t7Exc1qZB3yYakzSxxFU5CNiRi9Ym+ukUgchWqizC7i3tLllPe5tM2WC
         zimewHMwwx1hRQXUZqvfxbzbA6PerX8ta1xEim5IfFCFT9e0yXtwJNGVsTBwCfY7EBs8
         /WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082036; x=1754686836;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yXiZrswsxQPUUeYFbRHdd6ObCCznOMCn+Fx47vEWLNM=;
        b=aVsBQEQ7Sw4IROmceMk4cdHtmkd2bkEVI7wQtiuwpvTfzlUdsjJ14x89MARYZcsSyO
         rH3seLmZ7P2846U/902AjEWzH2nFQFJVjW/zAYya4QbC0JoGEQyhdkTo75/dV61MES7/
         JvDkYQUe2ZEUtgefj1n8njDymtGAPZRtjg90/XV9SmLvJ8x7FOI0VtvegRWCybAk53Vh
         u5dNLbwDlasxNyqOJ13d98d0+YOvb122Uo4G8BUnSpzKrRGtE8pcFm1Rq/ijyeFPXPFw
         nCIBnvwPz5PlvrYv8fo4Hf0+wKj8wbz8EkD36r13vQLw8zmEYqwHpqnH+8WLaFleb8/c
         jkMA==
X-Forwarded-Encrypted: i=1; AJvYcCWyWSFqQbdX39IY5X5/TPbUqG/es2MIflVFH1+V+PAmIhkKPguMtKEUOsc62bfJWH1wAT5tpBWZ/icXFDcd5Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzti94+VEDM5+lgZXGyFr8RVh45I3VZ2y1DYcyHK31YQHc/zjef
	xGdm2gQCfKNIB5Sh6ZF/Dh1WewpZyX9tBIy321I2vQxkSjh5nBNF7rEY
X-Gm-Gg: ASbGncujyoQBtnhKmLjf42gjqRjDjNOoz+lqm4S5s1BfEdjQTy4SXtJ9jJQD1Pv3CR/
	zbzdKWQkez9q8BD8lXlwNqMvsv+F61o280WJVL9vblqiPBM5JpuICAuMiyEUK0QW9wEGz94i8LI
	0HSDJI1Bqvdy+aVaDy2CKefX38wb4nw6Ob8KMViCw7RU4idcFoxHQj3L2CzggXgxymSKhQJqvR2
	zX/Lem0el0puarA2bKsn7gX1LsLXyHcDplht7z0mN5g2C15GGkebp9y81yHDzb/lJWFqF1YKgeI
	N6WTh5tnVSvPRucs9E+SO0pzWUtCZEtZ/Ud6FM5ct2aQUj8nTEUFlxDQtLyH6gM0Rz7LMp409+6
	emca2liECRRyVS9v3o6lJV0a1fZnH1dryi0R0CWWB3++x7bkpEFhDyIvcdPTZQAgZVA93Vg==
X-Google-Smtp-Source: AGHT+IH/GtIwQeRCat5yRdiTEzdNPzy9xXlmJbxZKcaISJhOGj8/WfAoR/JRPPjmAvN3qT1Hyj2HQg==
X-Received: by 2002:a05:690c:660c:b0:71b:657c:5878 with SMTP id 00721157ae682-71b7ecdaafcmr15462037b3.4.1754082036006;
        Fri, 01 Aug 2025 14:00:36 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71b5a5ce7b5sm12624577b3.71.2025.08.01.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 14:00:35 -0700 (PDT)
Date: Fri, 01 Aug 2025 17:00:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 matttbe@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <688d2af39aff_2e1a6829416@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250801181638.2483531-1-kuba@kernel.org>
References: <20250801181638.2483531-1-kuba@kernel.org>
Subject: Re: [PATCH net] selftests: net: packetdrill: xfail all problems on
 slow machines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> We keep seeing flakes on packetdrill on debug kernels, while
> non-debug kernels are stable, not a single flake in 200 runs.
> Time to give up, debug kernels appear to suffer from 10msec
> latency spikes and any timing-sensitive test is bound to flake.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

