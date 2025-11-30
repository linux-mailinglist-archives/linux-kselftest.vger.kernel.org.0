Return-Path: <linux-kselftest+bounces-46760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C996EC95084
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F3F84E023D
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3BD1E47C5;
	Sun, 30 Nov 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXKYdgPn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2924137750
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Nov 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764514589; cv=none; b=WZrtcW4IpSuA8UpO83pV+lBTVA/MEQ+dCoMKVaM63D4afl8dYWiuyiRL9itKIS7AZgZziMftHLpJGQC0mmjPmew0IflZn7L3+G4baDLue6H8QvFzgRwPG7Xd8pK3Oztexg9jrOaTEIqjSe9x2zkzN9rA9BkpP//sI6XQ9sAg9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764514589; c=relaxed/simple;
	bh=GR6tHVaNjyWFmD9BnnZ/bbyTDVzDet1oGY/woy6wm/I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mcpbN1KSKgZ9g0RmYtk0Dzgn1XveDxQdxzX4L3AwIjCPPwEU8QQRQhTTpp822KyKERTHAjpGLAJQ3KxYkN1HGLgEh+pi/ejj4Cz6iIL2Egw3Fz+R4fuBpTuhDcGgp7GOzzFuMEhEsJ3R/wfHy+1WhkJ+eCTvlZFUChjUnAJvpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXKYdgPn; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63f97c4eccaso2869949d50.2
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Nov 2025 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764514587; x=1765119387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VeJ8/WfZFL17L4UeNYaUU9mvWGExfRheoQkSxnLxjw=;
        b=dXKYdgPnPeWFqNPdyrmIijzOLgeeWxkKTQpe05+k2OBe23Ft3q6dTfGa3dZt8Pid9x
         IKZb5qbWmtQ1A8YWeca2TyuidGOm+aU8WByUwI/isZ6Z5a70StkZ2MJlGCVjfhpu8Io4
         PQsMsourjeYpEujsZEuF+mNn78g4CR469TSPQOjIKpcuFHb1S7SpoWEJhOS2+2/+49XX
         S20ThOb7VhLDkxLt6OpnEtgDSyf1QjkTapyP5R9UWcUooq2y9NLTZx52RUYLuZ1zvDo8
         CbdlyYx14Dpz9w44BVkt1PpdVvT+wc7vUGcgAZJhwmsJfHQUjFYxtcMnwLFiuzvkyn9d
         O8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764514587; x=1765119387;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VeJ8/WfZFL17L4UeNYaUU9mvWGExfRheoQkSxnLxjw=;
        b=mdPbweePoQcJDFeN5hkZk8L3J5StNLhPLfM+6rlhtIag3PDEYjXR5DEGCa/8jcMm5G
         9K6g3s8SCNUho9/d3ZzmHcPlsTvlrIAYE34BrVbzxvs3K8kY1exJ/aCEeWyzhMySUs5E
         zLoQ4nV4/SCHwbIG+izLEg0jqCjiyPV1oitlrF7eXwwoXhEGxh6pmvXpvqEQj6Wg/nRO
         9KAbAbFFwm/CGSp6KuL8tCYyCAghcK5Z6THAcG2GsNnjuUNmZyMX5ZlrdJjBFrAqjqZc
         BkmGYZ6wceLUAcTbEnfUkEV/a+0A8HJdeu6R7xtGSOern2US/7xBpj4k63qM86YQDYiY
         nlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCViXc0e/7EogMUbfgQb91y51NU432ZZ3XeOyKjwo5luMQRlrnM0B5jUH/fPpVv2GwDwET/+I40vgiHKLUUcmus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwpZ9HbjIfgrN6wVX09xmvhI0v2ujQCRc/z2J+S2EmM1RWswP
	g1fnvKjmX9E7shpDDr6PlfnqUNlpWrrpklQosUPZGWyW8tA7rxDCbvnJB33Q5Q==
X-Gm-Gg: ASbGncs0oXlacGEpOxzWzrQo+OD/Hfh/J0DGY4+WChSuweOODTdN8OxXjp615efNht7
	3MVwVJJqrGL7l2D80Aq0Qrfvog3XPozHQvVVx8TeuBzsm/WDCinhNUK0+mK3hHFsX9czUqUB7GK
	eFR9StyF5UaZqt063+NIGUs9T0w1vq6OGvUwlfIkwhY/GHi4VDhGlpHnyaF5bAAEdVLwET6cSrk
	LasLWSvKeYH1lLEH6F8YX8xhySqPhYISc4tiFLZ4JXhB9f505QWGaCWuyaLF3n0kbM+nScd7kEr
	dYuKzdD17Koc54yEKeZpRMVPPOSPG0zv1QtjJ8bG/bVE3RifvLLKhpHIkPnx5th4L6+orfXjo6n
	yNOXAkSg7rlPtSFATkS2CiTWHEiwftG8Q5v9cJnMqc87LbkqAOEEw5I6fVB7irMw63OfEWCbKwx
	jVbNL7kSWeNKIVHsEqRVFquyF6cjdWBNNQYANjW20KUBQ0L5rgFVUcjLAsgFgLC7oyvus=
X-Google-Smtp-Source: AGHT+IFPTqVQtufaeZBavUnDte8BHq8WTWpsbSj/iVUJTbGeRuuu6YTMufZeCzPk/5Xh4ok7CA1Nsw==
X-Received: by 2002:a05:690e:10c9:b0:641:f5bc:698a with SMTP id 956f58d0204a3-64302b1a261mr18403516d50.70.1764514586729;
        Sun, 30 Nov 2025 06:56:26 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6433c07530dsm3706754d50.7.2025.11.30.06.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 06:56:25 -0800 (PST)
Date: Sun, 30 Nov 2025 09:56:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3877052beef72@gmail.com>
In-Reply-To: <20251129173851.56cf3b18@kernel.org>
References: <20251128005242.2604732-1-kuba@kernel.org>
 <20251128005242.2604732-2-kuba@kernel.org>
 <willemdebruijn.kernel.468ae2cb7a74@gmail.com>
 <20251129173851.56cf3b18@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: gro: run the test
 against HW GRO and LRO
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
> On Fri, 28 Nov 2025 15:42:40 -0500 Willem de Bruijn wrote:
> > > +    elif mode == "lro":
> > > +        _set_ethtool_feat(cfg.ifname, cfg.feat,
> > > +                          {"generic-receive-offload": False,  
> > 
> > So GRO off disables HW_GRO, but not LRO? That difference is behavior
> > is confusing. Could we still see this as a regression and make the
> > ethtool HW_GRO feature equally independent from SW_GRO?
> 
> I couldn't convince myself that it's justified. Of course it would have
> made testing a lot easier. But apart from that - what's your reading of
> the status quo? Working backwards from were we ended up (and I
> haven't dug into the git history) I'm guessing that LRO disable is used
> to prevent changing geometry of the packets. GRO would presumably be
> disabled when user knows that it will be ineffective, to save the cost.
> Or when some portion of the stack (XDP?) can't deal with super frames.
> 
> If those are the reasons, practically, I don't see why user would want
> HW GRO without SW. Ever since we allowed SW GRO to re-GRO HW GRO'ed
> frames it's always better to leave SW enabled. HW leaves a lot of
> aggregation opportunities on the table.
> 
> I concluded that changing the current behavior would not help any real
> life scenario, just testing. LMK if you see one or the inconsistency
> is a big enough reason.

I think that's fair.

But from reading the code I don't see how disabling NETIF_F_GRO also
disables NETIF_F_GRO_HW. And indeed I just tested on one (admittedly
not latest upstream) IDPF driver and it does not.

Also, the XDP limitation is perhaps vestigial and could go away, since
generic XDP appears to support XDP frags (AKA multibuffer XDP), as of
commit e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in
generic mode").



