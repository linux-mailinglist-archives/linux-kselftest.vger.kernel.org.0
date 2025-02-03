Return-Path: <linux-kselftest+bounces-25594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA8A262F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B56A7A3F65
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F01CAA87;
	Mon,  3 Feb 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJATIDvr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373571925A2;
	Mon,  3 Feb 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608529; cv=none; b=CTFY7psNRgO0vhIjtmDaYR5x163qaQ12JPPXYzTUBwvPylGVqvCIL5mcXyulNcUR2Upw1gsuLsvDzkBMh2pRzBjwv1S0vy1O0i+cQ75xJmxgMy6pTR2nkXb4SkMLkjFWrz7Cd3WjsIebg4behKkoejUHC6nhoBP+nCDFuTS/NFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608529; c=relaxed/simple;
	bh=Lsbd4FEj52HH1IAKgnllNowWn3xfHmVQra2SG9SrUQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WaBK7HsgbGB5eGoU1kH5YV+UJFUVEJfBLIej7TPimOzgC163+6yP+a8EDf1WcWxPYcAaon3kiukrpAnL9s4F7TZKZiDRhIAnEN0nLPYGwpRdk9QARAjxvvk8TW+cGjVoTt0hZ3shj3eMj4zuwf75BjNkSv3PnMReOxPecddKskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJATIDvr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21634338cfdso17318055ad.2;
        Mon, 03 Feb 2025 10:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738608526; x=1739213326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lsbd4FEj52HH1IAKgnllNowWn3xfHmVQra2SG9SrUQM=;
        b=hJATIDvrctpi7zYmw10HjVi8cEIfHbYHhmanNT5Jm8FrUJymud8MBgZkFcf/IhSIO1
         bFJMnmqbNR5sfVf6VE7uXkN0ruAAH46O64tXUo8esB8PmgacNLZASfjW+Y2r4rlTYtex
         +tIlydrbc2QA1KkbXliHRMtIdc0IBzVTHyESJqVe2fDScwXT0In8aSJTKociYVcD2a4I
         ECnyYj2zpF8wT2Ht8caGuXdUm5HFJJhq6EcuscEv8hNuS1RWbKp6P0yN7pEmx0JZZuqf
         mUtKQZIGiidxDYzPnX4Cmmj4ecMCDVCqvQnEhld5EECDy+DleIfvXZP4tDoeDOXX2USo
         h2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738608526; x=1739213326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lsbd4FEj52HH1IAKgnllNowWn3xfHmVQra2SG9SrUQM=;
        b=DtNJX3lNb0AI/C9C+lfg2288ncUi/A4CTuT+1t6Tt8xQbywBJAvFPBZv0bXnrI3Umf
         JR59bnv8aYO7ogu3XvnWbBPSCS8e12nRKtvRdzCT9YxCY18pdTuDJhZC/XTJPhPp+haP
         OHxCKHPUqU5VaKmqxWQQzsBvhUpfte3D4TKmhSnyj9GYUFFj6qx+tt7tbdH0NFO617zf
         cRcYZedEk1O1eBYV9jsAylNKQRyVgFxsPPnRJRvjcL95Ul3ZCaRrwgaUqfBY56TS/G/Q
         7QQGB5pwburLpk5WMly+YIUl2RHsTMw32nbfFwIGgqOdn7XHQX22dIitSK8T4YCjnM0w
         pF4A==
X-Forwarded-Encrypted: i=1; AJvYcCV6nJFwm2uk0TpPbfLP6OrxgnTqq7nsZMATZhaPrmhTgO751WJGoI+vfjOYbKOiv0SHlP1aDnQRFim7jtzH3y5e@vger.kernel.org, AJvYcCWsrp0lqSSvoslw2wh8ZtU1gNu82qGDU872KO9rkYNYnC6vOML7rixfDqX4p6hdejqC3H3iHmp/POqC0ddJ@vger.kernel.org, AJvYcCX5M2T0b3v3G4Ti6gM2al9ogH2xRk9vdaOUN4K9IME9AsgWwZ6ESrewPFiP2KdRdVMwYFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHL5fKggkf0a8F8Ez9+IrkhZrkt+9l5WnXWosMW4/BzMqoYOSf
	6GIqh6kA7cvnAfhv5iW7yesCx3bJk5qNwuxOD7hm9JBpRNHPh6P+
X-Gm-Gg: ASbGncuYfjqOGq2utBumyAY9d9yozHRLj8UDsoti13LOvKMbur/1NP5LyADQhsF9kdS
	St0nSR5oQJRn+oD2vwDNljDhmnJiz9+ovHkK44F59H9PXqaxy5xxm5Jx752QA5RZc8taTQEW6xl
	OvFiCeyG7Gzix+iR/irK5KKj7InHpObfBPoJN/OBiRZGDc2ZM9jDu7jGRjFbCQg/XbZPl8qSWFQ
	9JIz/CmZe4Qeu0CHKnALOr4KmyIpom3qnAqvYzWrszD9tN7Qm8upIR2jAZIoI55gDOlMxW4A/mh
	fgTRgRTUuQW+
X-Google-Smtp-Source: AGHT+IFITU2OmUI0zcBfuM11sK28MhKdCTwH1hJZGMSzYYt5FEIw42H+u0k06fjcj+R4/qWCivD79A==
X-Received: by 2002:a05:6a21:8dc8:b0:1e0:d867:c875 with SMTP id adf61e73a8af0-1ed7a623248mr43239572637.36.1738608526355;
        Mon, 03 Feb 2025 10:48:46 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec096ac4asm8392673a12.63.2025.02.03.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:48:45 -0800 (PST)
Message-ID: <a89075ae0cdd03d94e61a009214cb399ad4f2382.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: selftests: Test constant key
 extraction on irrelevant maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, daniel@iogearbox.net, shuah@kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhartmay@linux.ibm.com, iii@linux.ibm.com
Date: Mon, 03 Feb 2025 10:48:40 -0800
In-Reply-To: <d6f48c9cb8b7981fd037a19a8cfbba5def40f2ea.1738439839.git.dxu@dxuuu.xyz>
References: <cover.1738439839.git.dxu@dxuuu.xyz>
	 <d6f48c9cb8b7981fd037a19a8cfbba5def40f2ea.1738439839.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-01 at 12:58 -0700, Daniel Xu wrote:
> Test that very high constant map keys are not interpreted as an error
> value by the verifier. This would previously fail.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


