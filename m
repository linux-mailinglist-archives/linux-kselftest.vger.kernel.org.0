Return-Path: <linux-kselftest+bounces-23654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A069F90E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 12:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9927A30EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695CC1C07CF;
	Fri, 20 Dec 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bImwbTGt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3E2594A8;
	Fri, 20 Dec 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692783; cv=none; b=WANxniocBGu1VQQN6gN0cM52CD0K0JNtSVdIa68YwZxhVwgeoDYIheV4SMOjOaL8WYkcHgjKuEt4q4Qmcc48v3gBW878AwxZiSqVKYUiSiBm88XxUSdueugsX9jzWrBK+YVBodDIujoJ7vnJbBA0CcnZZUV1mSVbFh/9wch5dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692783; c=relaxed/simple;
	bh=/ZDzMlN1Y5CWOBvGHDWuBBtDKiF44ozzaes71yDd7C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb9VkLHGKcnegu8vMCzRrnP/uJhZVKUZYoomqm2sRaYORmDS/Qrz9wUFXCbLmijWIzsXmUTGJcumvlMdnXZzf/j0tG1+YJNhKiWf9107Wt8f90UTB/HHGpT3vQE9seAtWumRkh2pfkRGjsxXRyC5o7fMNf38shjjb0yQSsD/eSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bImwbTGt; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f31841c6f6so887515eaf.0;
        Fri, 20 Dec 2024 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734692781; x=1735297581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZDzMlN1Y5CWOBvGHDWuBBtDKiF44ozzaes71yDd7C8=;
        b=bImwbTGt9dONedOtzGGYNb8W6E6NgceVquHKOdRrzNiROKPx9rPI8kgYbQSVIfMgKk
         1Kko0BGuyT+G4YPKn9Red6nd18mzY3hdv6Amtcf6aCiRsi6gLUkVKTh/Xvz56VCoNELN
         O0a3IVLDCrhVUpzB3TGkPwinseq1B6ZOZPBv965qCnKDO+fBAFNDb+rtqWAGxs7562YL
         d3axR5rGb/AOydw0XSrNAkYdovrj4vsL30KJ61sntULr8rmF63qfQBeXfVpUv6kQ62CY
         oRz7yuV8Auy8iIHaIpoNEY2/aijwLGHiVJrg/phEKpkQy2Cb63Zp+uknjc9c+iaoQABP
         Rgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734692781; x=1735297581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZDzMlN1Y5CWOBvGHDWuBBtDKiF44ozzaes71yDd7C8=;
        b=lvm9jzAQElxcvWb5ljXPJ1VvOXPyIKIQtSwBmALT6ADlzrtYX6epFopfas4Jk8lQwb
         2RUfmW/UyHQ2SRZyHNCVWn1XSSsq6C2h5FUSbQiT+GTg53cIT9SwAi/j++apVKUvHrUP
         q0ZeT5kzGJJPtK2yrlTluXdls93cgNEaPPyzS80L0QB/cKJneiao6TWV8KV1sj17IZu5
         usdp2wqPJ5hKCkY96p+08ULxfgAKBxLWovBJdjz855oDWFyUY7mMj7aJGfcWkfbszuG5
         AF//XVwSYDF2BiTMK/C5jxFGQgkchrMKPYM5bV2v8DC+MI+b8upmvGkzkffbc4nyVr4l
         SKFA==
X-Forwarded-Encrypted: i=1; AJvYcCUgcbpU3/g+cHc1sq2MDuB/Fw0Pqnccg98dOH/mrqXyg/5ROaB1uzTcrVqd2LLAOj2vPHHS5hC4ZRVgFxE=@vger.kernel.org, AJvYcCUiLGlXX/yx/AfqqHsW9U6cpt3+h9u8JMHGO64vWD6/DT78Aea1J7bf73KYxkjbj/lBP4P5w7S4hYjdv01dm/B0@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUyeYxmxxRfJsRCAl+CybomgO7wWU1Wm1Shvxv5/Bv7l4T7ak
	7LAYjg1QlNc4BhLml3pf/iv/5+f6sp76WZpZ/UNXgMU6VzzFkI7bPfd0n3uujCH6o2Ns0fhlQ7f
	h4odFax/tgtbIl3JtMWrSDJlNEOSgk9VN
X-Gm-Gg: ASbGncvN9zx4zO4XnnUBlFDtvp+vvpbRmu1GZHD4OUOAdvYRv1bEaLF/XX6QiTFKAbz
	/6cx3BJrAKsEXHQ/kGmcUU91D19RFNMUpZmIZDLJrn2T7xkPfK/wbsOvl32iTwWmCRFgQ
X-Google-Smtp-Source: AGHT+IGXEk6kSuQnhlhzJDbOplKyL9YbQH0k2oEM3yHbsMLFcHtl+jTiGbLT6wYwqrlIw+TfSuHp/jxm6J/XIJ7w5Ik=
X-Received: by 2002:a05:6870:9c84:b0:29e:6b6a:d6f3 with SMTP id
 586e51a60fabf-2a7fb3a6acfmr1157948fac.39.1734692780987; Fri, 20 Dec 2024
 03:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net> <20241219-b4-ovpn-v16-3-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-3-3e3001153683@openvpn.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 20 Dec 2024 11:06:09 +0000
Message-ID: <CAD4GDZx+HpD1W1pAWw0PL2doPD=M7vCXDb7Yooyhad+23m3SSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v16 03/26] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sd@queasysnail.net, ryazanov.s.a@gmail.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 01:42, Antonio Quartulli <antonio@openvpn.net> wrote:
>
> Add basic infrastructure for handling ovpn interfaces.
>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Tested-by: Donald Hunter <donald.hunter@gmail.com>

