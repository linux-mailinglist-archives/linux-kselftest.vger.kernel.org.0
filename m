Return-Path: <linux-kselftest+bounces-22804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325639E30B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 02:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A7516353A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0065567D;
	Wed,  4 Dec 2024 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OssZ8Eqr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE262500B8
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275414; cv=none; b=Nlaza7+BO+ugvf8rLKll7Hqmc796HB28yVcBl4uOEZtMCt72WbaByHUizy5TXSCKvsUy+fRctQPL7f6qBpRwsVp8QeDH0MgqKhDAndB5mNJCiJP2Eqddm3YB/8tIICs3WD01i4ReWQgXI/XwIP4UP6T6fJGD92wCxDG/IT8DXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275414; c=relaxed/simple;
	bh=+7qu2OdkMDrWyEA/AbNp/Eldt4Pq/+jBPwLnQKSEnQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5Imnc2g0dSG97QBroi0PfzCHgz1R1tPwGQ7kNUNnamnEYv7kywS9COwotJbEP0FmxOu3m6hJr43UIK6GwUAnyjFciAuIRhDnohiJcIVHVEx48tqbfyZftxhEKXqXnRgo2QnrxWKMgkKdycJ39L+io9ZTx8Tq4Q6+1dER6/3C7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OssZ8Eqr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215740b7fb8so37665ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 17:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733275413; x=1733880213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7qu2OdkMDrWyEA/AbNp/Eldt4Pq/+jBPwLnQKSEnQk=;
        b=OssZ8EqrNvOyNMZVXB8a0DK/P1EsUCSmrDWW+TJqqBj7w7N1NVMTT4o6ZjqpDW0+yh
         XZa+h6L/R6dOUjR1eRz/RiPuXuvBmf3rdNOe0tEUF9jM032goRChfZoBEJIs4K33AJ4d
         lUcdx7UWPtCUiUWWCJ+mQ+biWnFUAZnJfUzlNncuDo8DqaZA/7/B7TQ8i1io+yzuABQV
         NuFtE6YCfDWdwUs4nbf82yNCZppfL+s0hi4pgYKDHhT+Rf5J9aRvmWNGdSNZQk7dYDB5
         MooYUt4He+4MxEs+BEU/2vjTd6FqJC/lgxp4DtBRG4LL6Del0GgNvb0dwRSbi7bP60N9
         chOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733275413; x=1733880213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7qu2OdkMDrWyEA/AbNp/Eldt4Pq/+jBPwLnQKSEnQk=;
        b=Ck5wmchpKyLIJGAgc8APi6evQc1NGz697x1S4LPRtfupCmkZtuJPor+UsYT/UZMcru
         koRIXpNyJOwvVWIUKN86RfEFlx3G0juZ1BybNDImGDagrEmWpkFWs8h2eyEwjVTZ8Clh
         ISlsWmveYGo2+XGevRcRLCd18oU7kmjNS31r5eLWkkyStuX5be3bTVD0DijWIfpRh1kv
         P91RZAyALtUCA1WjPSV7fiE4PbfWwehxhWjCt9AulDvD7RahDISfg4/qU8UcxlbCNKAe
         F5Yr9YRc6bohm5T/xgxEUDueKdkUMQmmURy/QkcCbrdAig7/kL6uy+NiTzeB8wZGA4eE
         4Lww==
X-Forwarded-Encrypted: i=1; AJvYcCXMdamxhDU9DNzWWF2bOz/mkBGZMHkMeJ7Xu7UIyBkbNj8iJuqNwYPegYGOHqtoB3seWLx+ElME0Fe7wN15GrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaXRuyhKTdRoA0IKX+7K7UHUGfH9886smLV8ZthCOwDkI75zN
	crIljCnm6b2gri8Gi2BUKPnKzEa4eKPiiAkjFYqQ7lqKjrgPwSJEVgpMU7wYSufOAmcKePzwr58
	p7DKF84bktc6lbIg+s3u0GSy+cLHo6eKfV5lLfMcUITcjoaso55cY
X-Gm-Gg: ASbGncvLY0Edq3f+thKCl6QsTc3fYSICxjVbTzPuB8Vc9V7kLeV0EyIFtAV/toJyyit
	0lRifX6TQdLzW0GQlugIrdHJsGi+fkurBVa0lvn/a2rbRnBEzEyMCasUI2/4o5A==
X-Google-Smtp-Source: AGHT+IGD28NPEj4py7ZE6t7UOPJEzjj4CwV1nKf1e4xWMi3ISwCNz9WuJpdVSU42ZLi15gw0WaF/NMUP2mbpoyKo0J0=
X-Received: by 2002:a17:903:2a83:b0:20c:e262:2570 with SMTP id
 d9443c01a7336-215d6c3ec59mr1174565ad.8.1733275412322; Tue, 03 Dec 2024
 17:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTThMBDKCXufNaeci5uCeddOgLvXmqszyJoT6N=6xtWug@mail.gmail.com>
 <20241127232133.3928793-1-jrife@google.com> <20241130095624.1c34a12c@kernel.org>
In-Reply-To: <20241130095624.1c34a12c@kernel.org>
From: Jordan Rife <jrife@google.com>
Date: Tue, 3 Dec 2024 17:23:20 -0800
Message-ID: <CADKFtnQTWLyTej3cf+SJMWHNMPvZetfW9pUMH0K-tBOGxXLZRA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

> Better still use NLA_POLICY_MASK() so that nla_parse_nested() can
> perform the validation and attach a machine readable info about
> the failure.

This is definitely cleaner for the new WGALLOWEDIP_A_FLAGS parameter.
Thanks for the suggestion.

Applying this to WGPEER_A_FLAGS would simplify the existing validation
logic as well, although I think it changes the error code returned if
a user provides an invalid flag from EOPNOTSUPP to EINVAL. I'm not
sure if there's anything relying on this behavior. I'll let Jason make
the final call there.

-Jordan

