Return-Path: <linux-kselftest+bounces-15109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0694DC4E
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 12:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8771F21B3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07514EC62;
	Sat, 10 Aug 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9PrzCQ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182D21A0B;
	Sat, 10 Aug 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723286027; cv=none; b=LadTyOn+pyVnPIKyQOcj7FpwXaudVPJ9P/GmLeyDvPOwE6kfLeI72DSVX5zHfhfjn0cK3N/uf5GPqiZb2h0QFBRIt4KjA3sqdb6d7MKFJyQLLCoZt6l8JhPSbgpDlPfKII72by5jHQZg526ab91Zdp0uuTznbyHuzTm5oSpRIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723286027; c=relaxed/simple;
	bh=nI7ih2gOYl5MyaoHRNLJqWXVN7z2+2CR5szL++U3ldo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4AF2pxULLCY865yW5mt971VEMg/nhdknWv5bgAeLusymNII5P/LxLTT8grfBSqSd29eNshXlh7t/bRUil79q0yYp8gG9vjb5gTHoPbbDeOjic6CRRhai51Jye9cSyHTx5YvynjGi57iFCvKXolg9qlYzvZdZWCj7ptJNEwhFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9PrzCQ8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so2020175a12.3;
        Sat, 10 Aug 2024 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723286025; x=1723890825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI7ih2gOYl5MyaoHRNLJqWXVN7z2+2CR5szL++U3ldo=;
        b=I9PrzCQ8+jHFejY3W2vWUslGjOi89TLSYiM8aG5zKzdahU6yTH8eJxVk/qwxVW/FAl
         DjAHF7zRLKIu2nU9Tu9p0NkuulSNutshYZsfvttdgOD9xKNJ48e8hFs26EM9T+CRmTXm
         88iRq2MilpT6JK4nw49HKFrwagWeZqMnPadVHRJVm6x7XH7/5fOHpSe1yvdfppgjZ/Mh
         Yew6iqOIGSwakj1Co6adWlIigxkfb75gjR4fB5VTmYTqAMdPk1WScp9MVcmo07diXEv6
         UrxcVZ71JZ/ME58zFBGdj0n6/zc/fgoBVDGltgJ9cs/8Rmxkc61an0hJjyR4RWUp2AJH
         zZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723286025; x=1723890825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nI7ih2gOYl5MyaoHRNLJqWXVN7z2+2CR5szL++U3ldo=;
        b=f7wiXDm2IwexxmZHFbGhJRnYQSgJdE4dksQZz375dygZkujD1pfsLhFFPQTZPTK2HN
         FNHMi8Taq5evRRm9fAWFIxpXBZkpAUKQCUZoYBFVtqokuQ3NgMlc88kkWTpAvWdtgW6l
         fuLvI9sGJKApcWaNPK61WPROFkvoNoW3YevgCdkLtSQcd8xqlzmr4hPjwz6d4oH2lBCn
         VYRqnxO8w2LJxmy4WXX8c+6o6HQooSpboG4diYRixgXwpQoyH6XjBnSiO5/q3sbF/ueW
         Ct/Wg/nr7qDpqiEPLIV58bAZ6Ntk004AUJTtdD881+mvEh0WB2692oOZfkRL1VS4SY3x
         BcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB7CoQYOm/pyDrOQlvzcT3xzB7n3+8seB7RAhbfb8mh0uTrUUWoC2dZqzxfsLxZQiwLT0W3VyQN6kmbYJAKcWtmpC7KMzv5P6kuU8fsYYsC+teNyCN4XSS0y3pzTy/sLjEQebLnMAMN9fpvdU5+Lc60AEB5I5fgiktYD8xmG0FHA59JA4tuns94f0QCtc=
X-Gm-Message-State: AOJu0Yz6ez6xU0Iq6nDN4D1bvPpd6+ua8/JkYoIWdPPv7+2U4D+ABayb
	VpjnogfwHnm8GTx6X/s2JP5acLCp+ldqv5QUwjgo9Ig4EhYUXiZaGj5bNJ9xokgMs+nE9lj3E9P
	faZAX4WkzKkGMDISv/+/tb2ifKkU=
X-Google-Smtp-Source: AGHT+IHHJ3ZHq4puHlDfT8AAzXDPrL61Am9r3Ee6U6noqrOwUCfhCXSbKw6J1SprOLXhvrrPkQRBSMxioHzaul4bsh0=
X-Received: by 2002:a17:90a:1301:b0:2c9:9fcd:aa51 with SMTP id
 98e67ed59e1d1-2d1e7f96d90mr4508840a91.5.1723286024997; Sat, 10 Aug 2024
 03:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802124536.2905797-1-anders.roxell@linaro.org>
In-Reply-To: <20240802124536.2905797-1-anders.roxell@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Aug 2024 12:33:32 +0200
Message-ID: <CANiq72kM1RsZCrK-3gFZufgeZQRvOBAbO=DwRHpukX5W=T=UAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: rust: config: add trailing newline
To: Anders Roxell <anders.roxell@linaro.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	shuah@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:45=E2=80=AFPM Anders Roxell <anders.roxell@linaro.=
org> wrote:
>
> If adding multiple config files to the merge_config.sh script and
> rust/config is the fist one, then the last config fragment in this file
> and the first config fragment in the second file wont be set, since
> there isn't a newline in this file, so those two fragements end up at
> the same row like:
> CONFIG_SAMPLE_RUST_PRINT=3DmCONFIG_FRAGMENT=3Dy
>
> And non of those will be enabled when running 'olddefconfig' after.
>
> Fixing the issue by adding a newline to the file.

Could `merge_config.sh` be improved too?

Shuah, if you plan to pick this:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

