Return-Path: <linux-kselftest+bounces-35980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237AAEBC9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F993AD5A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92322E9EC9;
	Fri, 27 Jun 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzrfuxT9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689E2E9EBE;
	Fri, 27 Jun 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039755; cv=none; b=oyKpZg3XvClekYRdNWcMYbGO+x1zWvD6bNca6mv0tk+HUMevlYQTOflEn03E6fotNdHTeIVHqkOLsJIpie+kmj+2yeTu3TR/8DE2TcN+JofTye7ccaN+ivKwVqVV7yQnpmr9zIL2QCu3wVs35wdrPyCPvjKQxC+ApJ6S2GBokVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039755; c=relaxed/simple;
	bh=qR18cTUWuX3iyRqiUc17RFRmKOnhETWIo4lFPHoTfpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmUuOkoKjuWoXdqw7hYSZPqELTizt64VYHl1IRN4OrKBcGFTnmtGTJbo2P0xBWEdV5hMA/zb/Fu6Frr1UuiUEke0MTCGPEKQpdZ3lNQPdPd9oTtfxI36iwkSHW6B95dDa/oE6BapXFI6n0U5YNRQG4UTsLSnBYbnbmVTH+lFD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzrfuxT9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31c9d96bcbso353599a12.3;
        Fri, 27 Jun 2025 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751039753; x=1751644553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR18cTUWuX3iyRqiUc17RFRmKOnhETWIo4lFPHoTfpQ=;
        b=hzrfuxT9DZx3ZJLF4WMfdPuE9KqOLJ/dOz4s1K4Am10v9wR9b1h+KkqRMWj2dhGfye
         vSkzkoADhpDfw4h307XgdZ3SCFPB59cqzs1ttg1MToxLpJdeN8MQ1i6koA83o+VOuXHz
         UEP6ASdrYar5k+JC6DWplrouBPkGcWMSioc0rwsbYzWvdGFzNvb1mUwsTfUap14djKj4
         XmisHo3p9dyraUKEYrp1LlgeaBqdAY6wWtM+DT/PLXi49tdvwT7mdQu82agXVy9aFiOx
         gKNbvvAzcsAFln5Nc2lpUtCQ8I952LKN1r+g3XFZVL53N0IR4Nhwh0MWX96rTWnH0pCi
         3lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751039753; x=1751644553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR18cTUWuX3iyRqiUc17RFRmKOnhETWIo4lFPHoTfpQ=;
        b=M2/W3+lmIFnLgcU0di7Lc4NbJL3BZRAvp8ihH+v2Nu68TPaf7d5lTq/xKmZfDkYvhT
         JR6cD+sa7qvC3Rs/ND4WzS7susu9I3hFqAV3uDMxedyqodePVB409vIRbShoKSIwiQSS
         bwZ3NW5r4D7m8wCMFITG2VYr8yOfLrttmArKyGsifqsVNCLK9rUykfnsuBYSrfKwWXkg
         uaqrW7IbjEUGyXRdkQpXB3PNNtahFJ9Uy2l427dV3fUYZkbKd+cAr0TtLk2g2GyeNire
         dcif6UuSbByNr93TPSaa8oxZjlnqm01cZeaRZb9IzEDIwpO2Rwv1oXFVJHECM1/uBCZA
         KXpw==
X-Forwarded-Encrypted: i=1; AJvYcCUncLGVkoOQpwzpEUwBohUN25VGaEWAcKSy9JNOc672U4u1FxJOXjTlIVENE6cT/pVebXl7UuL8V+THo6D9t44t@vger.kernel.org, AJvYcCWsLDnfYzxqCKXa615Tr7TVqaN7uP95s6KkxI1tQg62iEfSX97AOFIGZKaBtkBYuimoJzrVFy7wka9bvjk=@vger.kernel.org, AJvYcCXY0iM99TzggshKa9jjNyAzUksO2MlkdVFtkEZAl23iVyqFC7R5HbLdSru2SOpXLBXKc2hoAoC1ybQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZT7E5fPOBoowx9tp9NXbepgnaNjS/X9AUX3GEDI+6g7tHl4S3
	koXBZRY9lA+iWvWb5u3lwadWwoJChtSo57sXco3FM3WFdT/sy0HBGj5A9CD/uKJiPWWLqmDDXSy
	DUVz8yJQY2kzjQxOOy93eriXxURC7PRI=
X-Gm-Gg: ASbGncv/dh/1zZArMtuyoLruwyqgKnJSP9YHzI4l677SYyVfNoXlrnKaTxuZfZy6IYw
	QXr/qRy7KD+jvOJjGks4CJY8LqfABVfns/rOEcnUeb8ec4FujgQiiVVx8J9oC9LqbCv3JML0k2E
	WomQKJ8+OFsEy/Dw85wjBLOCsQUOpiupnLbQUa/pG1gNs=
X-Google-Smtp-Source: AGHT+IGN6YEW92paeLbaZs5XsoXYtSHuth3PANHcqnX+XmQpfgf/Z7DfMegSfka7VTzyghPK37/ZG+RKRFfncihR0Og=
X-Received: by 2002:a17:90b:1b10:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-318c8ec50c7mr1925237a91.1.1751039753303; Fri, 27 Jun 2025
 08:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627065320.9315-1-work@onurozkan.dev>
In-Reply-To: <20250627065320.9315-1-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Jun 2025 17:55:41 +0200
X-Gm-Features: Ac12FXwWqPZ-RH23RzF3Zkjn5Me5jIb0nMknqKxJPf3mcgH9SsMWYI8xmoteWGY
Message-ID: <CANiq72mMEEdP1ZG2brhLWgjaQpnwG+Mcxm43B0hAvZuaq-=jBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] replace `allow(...)` lints with `expect(...)`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, airlied@gmail.com, simona@ffwll.ch, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rafael@kernel.org, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 8:54=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> The `#[allow(clippy::non_send_fields_in_send_ty)]` removal was tested
> on 1.81 and clippy was still happy with it. I couldn't test it on 1.78
> because when I go below 1.81 `menuconfig` no longer shows the Rust option=
.
> And any manual changes I make to `.config` are immediately reverted on
> `make` invocations.

For that, I recommend using the `/` command inside `menuconfig` -- it
allows you to see the dependencies of a given symbol, and whether they
are met or not. That way, it allows one to understand what else may be
missing to enable a symbol.

I hope that helps.

Cheers,
Miguel

