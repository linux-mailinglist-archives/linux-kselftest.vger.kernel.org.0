Return-Path: <linux-kselftest+bounces-38923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E02B258E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 03:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55041C21816
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 01:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93017C21C;
	Thu, 14 Aug 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl7vn7j1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70E111AD;
	Thu, 14 Aug 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134456; cv=none; b=QJeGOip6m9u+28TMR/fLt3dpewt2PBpbjO33Xywy9iHl+kqiYPdEEFqg4M5CpUyfiQxR4SbeAQrnKuxrDYH/9XlyUFg6/l+g/MYuk6V78BHP8jY7RaCSLku8U+Wdf3IDaKTSgx3ojtY7XLmsoUZO/KMdsuNFX/UCcPK1qa7N4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134456; c=relaxed/simple;
	bh=0hizZhAEgUkCHkGOmt6PI/Filc2TsmOiDTjNc0CIcww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeOxWkCr3FJ2pYnV/vp9eoDezCik9nhhNRVR+L82QUIBts8Hyjk0FSDdHm61wWe/jq8/MiTYzWEvZBgC33T8hLs9g7LzoJnaS0bhDPJA9lUD3jAscZBjHV3KBRDX+9JDXYtpvQD/ICHVf5PMOXK5JR+cgR+GmscDv2fNT5I6JcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl7vn7j1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso641610b3a.1;
        Wed, 13 Aug 2025 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755134454; x=1755739254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Guw3wwCgargT0Nlmks06vykBxwY5jk9d4/oR9B6cl/8=;
        b=Hl7vn7j16+W0XPCAhHodGe2qQvxMf2cr6vuv0g5C6D6ZRo5J8pD66udzHAKoTbMc27
         H4KsekyIkpgC2hjU625j5IiPT82a8YoqSb/AbCmc8sTexrjA2pntDIBaEHzenhI+0PIN
         KgQpILFBjPBUU26YS11OsdVGcnGgLff36ksOSVdHR78XFXdUJbz0f4qPhN1CaC8/paDt
         QMJ4GC7WOdpbPARKRlrQtQtdaShaQz0B+e/Dnt7CU+GTm0Dyl4ADUwtnamhwLSyhJmQN
         jVqN1xo/rkO5ih8VbOHkeLcbgM4Y9h7QrILTDpobVg4FjNrRaHB+qMFQUtfH9tlHNP2S
         6axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755134454; x=1755739254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Guw3wwCgargT0Nlmks06vykBxwY5jk9d4/oR9B6cl/8=;
        b=hmGRpyepYyaA+hbjKvK2VZGQcqh6G9aWbRi0RmRTccmsmxQ+vhDwUt9FXp7zIoaalW
         dXOr0Nh8EQHMfyeI0ostnHItD9J8lGb5w+/n4zkNC3jZk8UzeHQpN65pTAHVlmP+4Tcq
         gD9woXB/ehxTi7xTpkQAZsLF+7d09h7DbBnDD0qgok/nqsrhqG8Fb6y/ISLrsDA2WIHM
         a5060XqQUDbjLGgO4TDiUZSXR/6h3gO4oBcXA732jC2e0F9NJX0FDsTetHddjK/qjusD
         RhT1T+qHdt3tOAqZ9PV3xaA14rk1d/ENjMYaXUUd3H+HFz9HyaMxBhevE/K88Adqmj+z
         m8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUtsuhRbSbb/LjPliqOaUXlZM9/eqIUwvfZX3BMU0xYu0Z8eM0KZRdFcJftpht7G/qPUqcvzgVp2744@vger.kernel.org, AJvYcCV4wR5zx++wjcZzNBF7Ww/dz5bBDz8u/g+njjIClGy6/5UA6Mj6UqLC/kPTR3pp1Bgb5ln+nD+8dMA=@vger.kernel.org, AJvYcCXlBYLcifzt1o0Loq9goKcfzweFHSGiWfFFzWbVXxamPbLS9fS8ZdE0z2a3R+KdYwh2gQZB32KsQjfX4oBorUKB@vger.kernel.org
X-Gm-Message-State: AOJu0YzdO1NgXD4SVq/JzpsBvUgjhnQUv/Fk+cqldvT83/Dikx7hV7Rl
	pkh2/HR9Ju/5ZPqR0nzJKNeVVhl6iFragrv4ry3ImA2z5MJ5GEs+TEuL
X-Gm-Gg: ASbGnctjasOP65biZNjrS2HdYY/jSXhPTSlLUXUAriU4zFtP25CAAKlkZAfb0lFutPK
	NUWkTw/HEddA4+uMk4UzeLjWOzv9xU8En6IaYVfU2Bg9tK/uH8Fdn1tUnjdZhn1OJRnQ2tJFNC5
	L7+P7RLCKXwN7quNglLDEY1AHD8sMsHN5KbPNxFdKd20W8F267boqJnFShM0JZLUJ6c4xlegde7
	FxXJ6YQSmBtRQihLZl+/mXVJyN+SZ6LlkX8Uo+W02i/w9XwvgEzlBvJNltTKd4lpYDDpyaZdX0/
	365KmnBoS80rXw4+MT7x8AJigG7MrPNv0A1ZFd2NqLAy+bXzgERrfspgLT4gB1OcdhugOLAUYLP
	6cXD8fi3DqYe1sKszQzOFRg==
X-Google-Smtp-Source: AGHT+IEJ3OessLxNNIAojqEOkzN9L1bfGH5fpmiEEOiNt0quJcn4UMyAeV3e738guUq+hPTrMY6f2w==
X-Received: by 2002:a05:6a00:3988:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-76e2fd6aff8mr1774263b3a.16.1755134453727;
        Wed, 13 Aug 2025 18:20:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm33244227b3a.47.2025.08.13.18.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:20:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id ECACE4207D09; Thu, 14 Aug 2025 08:20:49 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux Kernel Selftests <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tim Bird <Tim.Bird@sony.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 0/2] Documentation: ktap: formatting cleanup
Date: Thu, 14 Aug 2025 08:20:44 +0700
Message-ID: <20250814012046.21235-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=496; i=bagasdotme@gmail.com; h=from:subject; bh=0hizZhAEgUkCHkGOmt6PI/Filc2TsmOiDTjNc0CIcww=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlzLY7otHJ0nJvMxbFGU2Dj2yPfm1+3/j70Xu+Omwvzn EkXEuL/dJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAivacY/tnznZ3n9a//+LQV afVF+zMlT7BZ69j9NuBbMN9/Mk+r6A9GhtkcEgei+jvj+vZ/9NG4wDu1mSGB/33Tz+M5N16Y5Sy M5gYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Just a little formatting cleanup for ktap docs (actually only bullet list
items fix in [2/2]; the first patch is trivial spelling fix).

Enjoy!

Bagas Sanjaya (2):
  Documentation: ktap: Correct "its" spelling
  Documentation: ktap: Separate first bullet list items

 Documentation/dev-tools/ktap.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 0bbc2548ea85e6bda835a08c6d47d46435945cda
-- 
An old man doll... just what I always wanted! - Clara


