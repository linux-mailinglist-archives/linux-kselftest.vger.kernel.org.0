Return-Path: <linux-kselftest+bounces-25715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68345A2794F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B21644DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F7216E35;
	Tue,  4 Feb 2025 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYkK83hP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E43216387;
	Tue,  4 Feb 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692377; cv=none; b=k2/8nM0TXrDMsB4OfxenqPavdokZUUeT0OoN9Tre9pJ9UnrZky7citIlv0CDmsjJ7EAnjlN3NYyILFt4SppVt05knzJ8JGHsFMQdNP7FIHCraWPYbR30AuQYOnOHyNa65r4voJO2kAIH2PNHM2iXiLgNMphVCcHXGWL6DLEmMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692377; c=relaxed/simple;
	bh=WNANZU+kfpdMeHPgf7iTwjf4f37XwN5zh6QwchBR714=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfOICBN2KKQngEOQTax5SC0KQ4esqaUSyQV90HiP4mAJWvwNRfTaN6mgPKaiiN1AvlbauJpJeNQYHHTks4sHIqgW3ZLoQbY8IbWeH+wTDFs1QGZRsDMgbhuL9NW+JohGoWs4A5/3Orc02mIbd8l+Pg27aZa0rLnVQ7D4gVfRdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYkK83hP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215770613dbso81041275ad.2;
        Tue, 04 Feb 2025 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738692375; x=1739297175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GrRDiNWwoEOAF9DAZE2HXZqTxhwU3nG+MjD2lSOs8U4=;
        b=AYkK83hPhJkfv5Lls08MzZRvOsRRuoi6tK175Qu+6HhEJMNBP1vBEab65A2Qj41U9V
         Zq9qqBgXAGaGOHN5PWSIvpA09fqp5LVHnII7810MMsz6mcPGjQrhRDj8vE+YfezeynSd
         an/E3gX35bq50ZIqkb2/66Y642H5/ELeAXgiLz3KZdYiW26WiKI5d2GXevtPPt4N6+8Z
         6AHkpS9Q6x2++tp+k21U3sVH1PrSx3Zt1yXaISneWvDQzdbBlXXaht9UEyajTSV0yh9g
         RFGsFBHRdgGBecAlWOSUI7pDr5wYq31dSGCgZmyk6O+xM2+x6ltfrKFyTx/dhieVpL5X
         KCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692375; x=1739297175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrRDiNWwoEOAF9DAZE2HXZqTxhwU3nG+MjD2lSOs8U4=;
        b=D5WA2gdevpPoh4oWjyaiGbs79i0yIOxWu6wfNx/Ta42zVyeLqueVIkD4XBa1xCMvNF
         bX1dy9Ezph+iBw1YaERb/zYzjx/fnoAWY9Ay90mOLEk168FmQn0FoBcwnsa51c+io/Ke
         dgVo+1ih0QWxpsGTZE84umQVCuhYAfGrgYVVrcYHEnPxXlDhhZ+V4E3PCIa7/t+a/2Uh
         pU5bV0uYPpvvWpEuy1MTODUe2McLtXc7T9lLUWIF/waZytynqEGEJwiaGJWAl0KrP5b3
         EecstIfEzUvsw7Hjbrh2Eu5Qq+xFFVFMjsJHRqUaEb+hPe5KBKy7T677HNZUb65cNQeK
         nV8g==
X-Forwarded-Encrypted: i=1; AJvYcCUuo5jJl/3L6HMTx2UTm1AudMkAMcvFFr0nUwRAY6jXNeuDzoDATlZho/U/Jx09yHqJzZHjtIOVn6pu@vger.kernel.org, AJvYcCVVrPWT3gtkhMkHdmja0u5xEUDoAwLriol1GdiQnk+SwclhQlYzxDVWUr0HXrlWTfoPtE0=@vger.kernel.org, AJvYcCVnWW+Xduj8+k89r5CSnj68MyYIooLv03o7yvYy57VnpYZQV3s3Ilb8zLluEPwj8fEdc8u2fFMe/A1HMFQoZ+8F@vger.kernel.org, AJvYcCWz72BDYEvzG5jFW8iqPv+2gXd/beZ94/YveCHXy7RDyAyU1pLTy/QjRgY5q6Thboh0AYkR9bxWivI65VPM@vger.kernel.org, AJvYcCXM80A4bzEsJ1MBSAr/4IeBVff9PVbCY6RRBwIL6BCWGZnJd78K+6tx4ndsneoih0+zmx/VfOjG@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwW0vn83V7Ff9QCWmRmQmTg6s8WRtdCZOtxpHsyxWFYsIPYfz
	H1gxE1amUA3Cyl5ggyfcCYtJ4a204thRPm9/2df4S5l+/BjwNIA=
X-Gm-Gg: ASbGncumD9Fzm/ZRVu8/I4YQOasO3pTmaNCpSuftpbYRm79APsnjBNLuc/jIwdBrcV2
	LHXZamOXSlbSjhIDHulFgbGlT+ahLAUlEhzJWJwmxqPzRhKgDhX8iOLwOvO2uHnB9mOpP1tTnCi
	eeGnXS0Xxdaye9d4GLLo0QNZN0i1TQybuWVdNUcuW7tTRN0MtxpOoKtAHELj8T5KvBY4wf9lje3
	RFu34Sh555LLlSOL3+zV+hicFKKtrpoKyAlF40Op/cNLKaCxOZ+setyjhqen1NQ+LrfyOkGen3N
	0t2ZvfJOfwvxCss=
X-Google-Smtp-Source: AGHT+IFYT9NcRGLLxVnZIbZhoBZTMQVypif42AJDxoHppKnt1MhQTNKBNnnBYX3HBXh5CANfjLqcdA==
X-Received: by 2002:a17:903:2a8b:b0:216:6283:5a8c with SMTP id d9443c01a7336-21dd7dd240bmr373053575ad.39.1738692374716;
        Tue, 04 Feb 2025 10:06:14 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f1363a257sm3297675ad.119.2025.02.04.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:06:14 -0800 (PST)
Date: Tue, 4 Feb 2025 10:06:13 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <Z6JXFRUobi-w73D0@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
 <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>

On 02/04, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 4:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 2/3/25 11:39 PM, Mina Almasry wrote:
> > > The TX path had been dropped from the Device Memory TCP patch series
> > > post RFCv1 [1], to make that series slightly easier to review. This
> > > series rebases the implementation of the TX path on top of the
> > > net_iov/netmem framework agreed upon and merged. The motivation for
> > > the feature is thoroughly described in the docs & cover letter of the
> > > original proposal, so I don't repeat the lengthy descriptions here, but
> > > they are available in [1].
> > >
> > > Sending this series as RFC as the winder closure is immenient. I plan on
> > > reposting as non-RFC once the tree re-opens, addressing any feedback
> > > I receive in the meantime.
> >
> > I guess you should drop this paragraph.
> >
> > > Full outline on usage of the TX path is detailed in the documentation
> > > added in the first patch.
> > >
> > > Test example is available via the kselftest included in the series as well.
> > >
> > > The series is relatively small, as the TX path for this feature largely
> > > piggybacks on the existing MSG_ZEROCOPY implementation.
> >
> > It looks like no additional device level support is required. That is
> > IMHO so good up to suspicious level :)
> >
> 
> It is correct no additional device level support is required. I don't
> have any local changes to my driver to make this work. I think Stan
> on-list was able to run the TX path (he commented on fixes to the test
> but didn't say it doesn't work :D) and one other person was able to
> run it offlist.

For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F31@mini-arch/
I have similar internal patch for mlx5 (will share after RX part gets
in). I agree that it seems like gve_unmap_packet needs some work to be more
careful to not unmap NIOVs (if you were testing against gve).

