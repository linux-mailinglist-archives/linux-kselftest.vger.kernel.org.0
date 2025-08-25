Return-Path: <linux-kselftest+bounces-39882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35089B34AE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB3F3B8205
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA0281368;
	Mon, 25 Aug 2025 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZI6a1ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511F1DE4F6;
	Mon, 25 Aug 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150355; cv=none; b=DGJ0CJa5ssQlGu9yncQ1KQvIN9LERwQfJQgOGQASYSbpTaWI2mGOhxxlOBXnOErkKd+JcuhU4Dl3JfA+rbdsv34hAzcbEIv7mcRZRLbxTXNecPg0XzleddMKQNSb9PB0ATfiXekhFVL+zaEshazVG7NKl6L/0QYRRb9gKQavpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150355; c=relaxed/simple;
	bh=v7m8S0eg4GCGM1ZCOPqJayGySDtuCRUe/QjHb6E9nEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHePUnldMr8o3KO6LYSALdF9g7sOvfg0VOTIUoPuFktQfhtDV9pTTtQR7zqLuQ6tYbGl7pHFoStKKDMl8zMS4esLne1qUI1jLWy2J5n6CXYJbuKkpq+XQYhgd0HlKMStW3r/jdTxB12tJz8zzbfwPTIFb1vH11PcCfGHeBUc4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZI6a1ou; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-246fc803b90so8306385ad.3;
        Mon, 25 Aug 2025 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150353; x=1756755153; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7m8S0eg4GCGM1ZCOPqJayGySDtuCRUe/QjHb6E9nEw=;
        b=bZI6a1ou+UsEv0cMtojan1YE/UKLef1fxNLxfOWLQq1XyveCPFMmafe3z5liVxQfSt
         cmeyVvnOgwNo+9nWbtydYQ/NDJPig25A0E7zz+eD1WENeksNchrBFsNNZRr51IMFMkLd
         0S41kZRaVnR4d4l+3xhsE7DZrQ/Bx/muBWj1+XTW4hb+yAu52Xdcc3ywramJ0ERoMPLb
         CN8nmZkVKI0Edz/aBof/gPbzhZV/qX+xNwlJIOTXVJVmxA1kjmvNS0ZrbPpBjeoLMO/c
         ysrUL8K+GdOW0p290TStMVp3SNIqisWWrdw294AE1h2DDPoXlCXg0cRxmE4pZUs5EUm0
         QRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150353; x=1756755153;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7m8S0eg4GCGM1ZCOPqJayGySDtuCRUe/QjHb6E9nEw=;
        b=dXHz9QqOksqXpUyMtBzDalCgjdskfJtRBD1ZIVh4jS2OBScwaT6ougdJ0vALqI5IZJ
         67Rj7mNPzObHlR3GoAnI9McNinK4L1X9TEBGun6hPrNIr/Ou5EEOWD7m7hw8rikSMDtG
         p9KK0TgmBIYyW+ecQTfEgSJXrxVOW5qiRyMoGK5EZhJ0Zezxw5/wXtfk4MeZsU+GuR1o
         s/qr5krRfB1NwdaEcc/ogBcxCBP7upROZ5QCSNiMpN1Rw58RlDkzsjKoD4mVGPCvv1y6
         paFRgjtPBqj5gCkejj1DFWH2VxjzRGCmoXiZcEU3JGVYsSy+avt9U3tlI7F7KXA8s33I
         4WGA==
X-Forwarded-Encrypted: i=1; AJvYcCVN9MzVgqKNQrBCGKZrwpokpn0lIurAYWTdz4tNl9RM/L3oxeTwTJIwZbCHRyebaN9sYzI=@vger.kernel.org, AJvYcCVwEBRbPWv+aVsbZiK5Bh+5gZ8l2GX9aTLLxqtlbOR0r7xLZW7LqGKU2LUDHfxVjSlhzGPILNZx0LeJgPvv@vger.kernel.org, AJvYcCXY6bzayofTddAvYEtXnNU4aLMFprIAuOOXLd78G/LIlka42ybFQFMyM6A8dNaWsZlzv+fIFhvjIP4PkrWvMeuY@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwowBmywwYkq50ovH14i8NIL8f+36GkUGE3UkTTsP+2zONY7T
	WoymAGjDS8uDWY9CVwRrjKlWHzaZIvtfNiNCOF3ja7boVgTaYZoPjXsx
X-Gm-Gg: ASbGncvTlk3Oo8Ymltxba09CKqaR+Y36x3D+0XtsSpf42xvhkz+lZisVDKikFIJgimq
	o9wWET28ADlHxOTk3EXPWqTwKxwJmLcbQ+bIsNeCjLCLP4DKukle2X7HE0RBWVGjV7EKbxSBSrR
	5lM/zyE50T2es7Zluc6nwEgJ/rkGjHMivpVwH/fULWfHs2UXtVUvCuBJoicAEtuTNzdlaO0OWMJ
	XpULN8cgVk3FDp0IqEImU//9zyDyD5R1hL+uyewKO8q6tYs785r79X/ZtHac1TW7lh8CRC7F94B
	wi88ccx8/X0ZrjZRh5ndcuUbv1iByuWp/DBEqcA6ezgfmEwsQwQsl1yesJNwpyUC09RSitQGovS
	+80X6aZxA61LbKtZSMncRnYWjx7EB
X-Google-Smtp-Source: AGHT+IF92G0qyzJQkmKboodWp3QcUrjLvyXbP81XhzGjglNuFKNhx0ff88z+lL7L63eF9UrbT3AfGg==
X-Received: by 2002:a17:902:e783:b0:246:d98e:630 with SMTP id d9443c01a7336-246d98e09c1mr51362495ad.44.1756150353021;
        Mon, 25 Aug 2025 12:32:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::247? ([2620:10d:c090:600::1:9c06])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668861220sm75758765ad.96.2025.08.25.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:32:32 -0700 (PDT)
Message-ID: <139bf7d77750fdf04d26e1a77c0955466c9a4827.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add socket filter attach test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, puranjay@kernel.org, 
	xukuohai@huaweicloud.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, mrpre@163.com, 	linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Date: Mon, 25 Aug 2025 12:32:29 -0700
In-Reply-To: <CANk7y0gVNwX70ur0KkZKNkSDq7RH1xs5=dOHx_UCOErbwc7zhA@mail.gmail.com>
References: <20250813152958.3107403-1-kafai.wan@linux.dev>
	 <20250813152958.3107403-3-kafai.wan@linux.dev>
	 <eb6f9ba4acccc7685596a8f1b282667a43d51ca8.camel@gmail.com>
	 <CANk7y0hQWOL3OW8Ok4e-kp7Brn5Zq6H5+EfS=mVtoVd+AUxZmA@mail.gmail.com>
	 <35c18502a4870d8a833c1c9af20b85ca3f8a0ff6.camel@gmail.com>
	 <CANk7y0gVNwX70ur0KkZKNkSDq7RH1xs5=dOHx_UCOErbwc7zhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 21:27 +0200, Puranjay Mohan wrote:

[...]

> Hi Eduard,
>=20
> You were right, I have verified that the program is hitting the 0xfff
> boundary while doing the call to bpf_skb_load_helper_32
> While jiting this call, emit_a32_mov_i(tmp[1], func, ctx); is called,
> where this issue it triggered.
>=20
> The offset in imm_offset() is calculated as:
> ctx->offsets[ctx->prog->len - 1] * 4 + ctx->prologue_bytes +
> ctx->epilogue_bytes + imm_i * 4
>=20
> For this program, ctx->offsets[ctx->prog->len - 1] * 4 itself is
> 0x1400 which is above 0xfff boundary.
> So, this is not a bug and expected behaviour with the current
> implementation of the JIT.
>=20
> For now, we can merge this and later I will try to improve the JIT so
> it works for bigger programs.

Hi Puranjay,

Thank you for checking this!
What do you think about this test case, do we need it in the suite?

Best regards,
Eduard

