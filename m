Return-Path: <linux-kselftest+bounces-46690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BCBC92483
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9AA3A276F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37A258EDB;
	Fri, 28 Nov 2025 14:20:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6C238C16
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339657; cv=none; b=oHt7cyuA3Jf4tpHM0WJtBgLrM9NQowHhQ+YlIYvrQJX2OiUzjMNomhRmQqIDxu07z7qKTGtskTlGj91f1AMll0nol1PmgHiCVTT+8TUEkaMgXOuRfQHtvTk7ZU2MX0gEBkMsuMRmcdqVFuP1TXS15N5QTijGWdBhrrK9Mn6dzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339657; c=relaxed/simple;
	bh=dlYzWgdKJezE3ECdVRuaFQ4lSQ2fO+F5ZxnSjSVmSQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F4ylqzjD3p/hN6JWUYMFDiwH1GUmJm1ZoSDBanhNU6CPDq/3/EWVsV2GXP6bQpb9Q/Q2qD2080pbjSRARzDcUzcflOrk8FSb6uyrU7h3TQLsBExlzEEPUABSd9YAscP9HoH/MnJd8/Oc/JtNAvdkLe9HgG7JUV5mEkjPJPyqFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c76d855ddbso310678a34.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 06:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339655; x=1764944455;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrbGLMdK80DjaisbPeaWQi49eJZoN/NohgD7YPqnYL4=;
        b=l1xJtpQk09AiULPaXNhc3Us6S4SsCMhbnot4k0P7T2nAdbnmRiOt297CH3/obpbclq
         XVWpzTt/0P2t2DAhrsHhdP/7bClLfYQ8KW6B6v5uGbKmG599XZLUX0RJS5JpejeW5aYH
         7zTRK6agDoxUGVaufxwAoqqeJCTOTxdPmZuVeYceV/2jN4d47bjjxdcE97hxhxn68SPQ
         p7sc9Yui1M5XAhlns/Uyx3U5AjZldLBPXMWdCOoO9n3H/GIyOu1HqrQ7lgz+vaPJdVPb
         AhDcO2JP5z6i+3j2ahIqFxeL7FGAibS3nUir0w77TREHW9x29lYKIkMh74sskPksrmSL
         ElDw==
X-Forwarded-Encrypted: i=1; AJvYcCVxiRggmeVD61KktueUoQ2IDdc4bvR8Ig3SI6lTZNQRb6hc79F/S9XIVZrM5tuN6VRuw4dkgGE4y8JZxB6/dDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgYAz4GCKm4/5Vy/Ly0pV8w9i1An8DB6SCPsQLK0mS3LLKqN+
	Yy3SilP5NA+NzArG01Qskv1LM/OB1AY/vYP7YMdSFGqVcUSN1i4weW88
X-Gm-Gg: ASbGncvyjQi3jx8NZCaR7w7Ij8BhQ02v1cHiny5CBPfCHbd5g1oVLqAu1oKePeKvzHM
	W7AGPSVhFFVh1XNelJhR1l44BImXCkOz4Wx5UIRISpos3ipCry3MX7IvgUlGZvy0VN02S8wSpnc
	J40LuYORz5196B5FTZGIY9EyE+ao1rSxSJGmR4uy1DSXk+KvefIfXEeTythw0g26z2Is6ZpKZjS
	PTWQPjvwk10teuJLW1j7gQUiAtSZEkNnvI3CtArSJTdqdINc0k2jqSP4WKVk8dzjN2VER8tPthG
	pqg31HjpUEI/hV0DWnAj/VEfQtTu47xmjWhDZY2DldkVIeTlz1JL30UkRu9aawsfV3dw+P45VMQ
	U68F4IeqQIE372HJ6fhM6H/1JBwjh09nz273dKgIrbTkj+yPC8xgbvFjEqXDxVfYnfe6uI1+xo2
	UeGcCTO0rwaUMm0A==
X-Google-Smtp-Source: AGHT+IEukTJJoSoCJBYd7Ajt13DEto12fjYWxAVqOZ1Kr7K6BN3PDrZk1Z2lUPjn1deToE63cQFX7w==
X-Received: by 2002:a05:6830:848d:b0:7c5:3c7d:7e65 with SMTP id 46e09a7af769-7c798fadaabmr12298319a34.16.1764339655389;
        Fri, 28 Nov 2025 06:20:55 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0f650sm1584491a34.23.2025.11.28.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:20:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/4] (no cover subject)
Date: Fri, 28 Nov 2025 06:20:45 -0800
Message-Id: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2vKWkC/x3MYQqDMAwG0KuE77eFtaLTXmUMGW3mAls6mjIE8
 e4D3wHeDuMqbIi0o/JPTIoiku8I6fXQlZ1kREK4hMH7cHXKLRW18ubFWPPysdVN8+T7eRhzCj0
 6wrfyU7ZzvUG5OeWt4X4cfy9MjVJvAAAA
X-Change-ID: 20251127-netconsole_send_msg-89813956dc23
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
 kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=leitao@debian.org;
 h=from:subject:message-id; bh=dlYzWgdKJezE3ECdVRuaFQ4lSQ2fO+F5ZxnSjSVmSQY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKa/FRtTjWQbN4ZRH8XIGVZNJGjrhySQJN+Bd4
 iKJpTr2BYGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmvxQAKCRA1o5Of/Hh3
 bZVWD/4lsRjAv6/OKe7Pq8tqjztfFUWCRfhj74SofeyX7dFqSIJ18/CVzl5tZb+rAGAdYFWWa1U
 h4p4Jpd0L6/rRuoQOyvl8y7UnaIcjp3N7LF/ndDQSnfPKR7ebW1ngt8mzGif9GLByLKWNqY0MWc
 xtq3hfp35W5Y3f41XyGqX3npzh+LBUxWsCj7fT8h/YlnDPU1xPUYbh0qgYpE222DCP7NbTe8KT0
 x8+v2GsldnJkdANyrhbNyflGGp8NWXx6veQUkBpirafxXIZpFqy2aOYHckVv6mqJu7Q1rKejvE3
 xTNKiq4xPX7ym2tc1RWEWkQ3qRe4jcIbHkVi4ZeqZK9kaRaXeBcesr09yIrAb0dxQv/AUJj/Vm9
 YOzeumVETujkqCFR34G38PlhB0Amk2oi5gsFEOzKLWfg0cAmhLTBPXZa9PoxkALHRV8BtUzfU4/
 4hZLdPXHA+MBmEL4zFIZ/ABrk8r4HSgEZPiJXfZXea2scpHUQeqtP3LdV8R3MUiogOvG6dpVi/O
 QOmYeZP8VBGgUqUOpYlkz08tK2r5Z73A6nZqujsrFzbex/fM8ZpY4vgBM/F9MaxaOKmtG8fepu6
 ibsjeneE8aso75R4Lu4w6G8b084ssSjIhzhMk3EC3+UQbRX021cMFZ8Hhl4SFaPgP06+/J9Y/iE
 mWQ27034Naq4z5Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch series introduces a new configfs attribute that enables sending
messages directly through netconsole without going through the kernel's logging
infrastructure.

This feature allows users to send custom messages, alerts, or status updates
directly to netconsole receivers by writing to
/sys/kernel/config/netconsole/<target>/send_msg, without poluting kernel
buffers, and sending msgs to the serial, which could be slow.

At Meta this is currently used in two cases right now (through printk by
now):

  a) When a new workload enters or leave the machine.
  b) From time to time, as a "ping" to make sure the netconsole/machine
  is alive.

The implementation reuses the existing message transmission functions
(send_msg_udp() and send_ext_msg_udp()) to handle both basic and extended
message formats.

Regarding code organization, this version uses forward declarations for
send_msg_udp() and send_ext_msg_udp() functions rather than relocating them
within the file. While forward declarations do add a small amount of
redundancy, they avoid the larger churn that would result from moving entire
function definitions.

---
Breno Leitao (4):
      netconsole: extract message fragmentation into send_msg_udp()
      netconsole: Add configfs attribute for direct message sending
      selftests/netconsole: Switch to configfs send_msg interface
      Documentation: netconsole: Document send_msg configfs attribute

 Documentation/networking/netconsole.rst            | 40 +++++++++++++++
 drivers/net/netconsole.c                           | 59 ++++++++++++++++++----
 .../selftests/drivers/net/netcons_sysdata.sh       |  2 +-
 3 files changed, 91 insertions(+), 10 deletions(-)
---
base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
change-id: 20251127-netconsole_send_msg-89813956dc23

Best regards,
--  
Breno Leitao <leitao@debian.org>


