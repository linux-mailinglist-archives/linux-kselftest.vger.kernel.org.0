Return-Path: <linux-kselftest+bounces-46875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4856DC9B5F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 12:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AD1D4E3566
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E795311C35;
	Tue,  2 Dec 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="FlfRja74"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B03126C8
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676337; cv=none; b=GrmnJqGYmq8bnvTC+CRVioa3EOzf+pq6U4eqz6J2oGKY9Yqum96kfzzs1jEtLXVy9Vf8OCc7xF5FjzuKjGU1csSH06EFEq0Mhdu8btcCBP13ZkOD7X7EJvpZYBVYmm46fmOiFXwuK9ZY8v0icOnaQwVdyp8EW266Mu1QW646tOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676337; c=relaxed/simple;
	bh=RZiMVeuMpFtsxH0FT6sSt415Si5xUzm3G12T/hIkpi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V9VEQi9wm7ijxEhtOTv8rhWUgnFLcLRpWrZvejyhjGoW/fXwh5xcxbR6MvconwvDOz4dqKQzQnxp7fjMQ859CP8wipV3G7qsgTlc5k4/NeIolxQpOoAAeUUQinfJXQUA87sRL13hhFrZ/wAHaDnYzjxQY1fSD6n6npdODroBxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=FlfRja74; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E60B83FB62
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676331;
	bh=JIEUjuYaaXoiZWfV9sg4WJ4d4l0iSxZy3vnXjkSudlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=FlfRja74bCV9cU19wK5RbDfTgf6DB0jtWsmvkFMVKfvff9szF9V/kDH+3lTO+Gre7
	 bmWYbIyvxTypT/nRdT6v25kBtZ5nrTnUKitvDGTfwHzn9a+rfGWdTxT2B9P1yA7cFc
	 4oQfSQTQPZtnbJpC5DwN0fA61uj4XJc+Ypx4/djPTidaxtO14LRM3gl6+psGzljWWu
	 znsVYFpMb7qj701J9mM50K9Liu3OXYjhph12ZQULavqGyHOLttPR3TMrmSMHKiOjnx
	 xI+hSFj1S0HeNA/mixVjS3DE1WiAyF8fGhbauFBrRZJC94qLXpTttAft8t3PFuEH+t
	 Z0oJLhAJRBwUIoRcpRCCeQxEcAFeoSCvPOl6WVl9YSF3Bxepf+AlxINw8AWIb83MfS
	 my4/DPdhhYxO4uTiRsmuFFo0bVu3hJzFWuWeHukglfUYtYYkcMv/gpxoLxMMhmea8c
	 1vaB2x7yuxAkY4XgvLQnlEKnarCKiPK+u3fP34Men+tO5C5NVU+lWvKvgHcy7YH4pU
	 kXzhGwOdnEi15PLjex6LVUZWkm/5PylZhB1pQ1nK3fLEVyDidPAVA++UlS3xgNUFAX
	 Hi48eHwuec2sswALcviSNNC5zwUJPqkrux9gJEH4SJjxkkNKvc1GVw0NGchW7LhbyH
	 8MqXh2yNwsvRngy1BzJEtQPc=
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64161017e34so6659126a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 03:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676331; x=1765281131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIEUjuYaaXoiZWfV9sg4WJ4d4l0iSxZy3vnXjkSudlI=;
        b=mc91MeEhZT8INjBodb1j80zalLcZtWTvA1BsHVU/wLCKmcRO5nQyQOrXgYlONsw7cv
         o0/I5yhTj1h43PzKy9hs931EM9PnftZaUjt1gAE8ReEcdYA3wsOYZxCRAdA/Vz9JV62P
         32pjpf/6EaKxNMnUjGpCLd7U/0+QWhGmj2wHtgvdHluZoevJKOtGhs5E+StouzjY1c7g
         BRYZ3RDz6seFVZqsjyp/VU7oOzcHhcp6OwqzRmiFE7ymxyWYslaZcz7uwGLfck3QmgQ5
         /Y54+JtAfirLdSfl2oLucjeWy7w/grB/h8RivlD2+13i7OZ2769AgXBNOfz+uFbXgOnQ
         AGAg==
X-Forwarded-Encrypted: i=1; AJvYcCUWeKfGP42chjNWZSCe8HhqQNAj4zauFJpM21UYMJwirY0dXfmEBcDX5YBoiNvH0eyKaaE5SZG9ZtGBe+IkQBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxc8WF8sAq3UZodqaJ6Ar31lKA85WA9JJyUfDXakceNGWgyd1
	fDGKCj38XU5I7B8QiNRTQIAqbi4tdf/FHormr8m9LIgnJayUMmZs6Ok+fa3G/lYxUba9gCvVZnh
	C1PbSil9lXfsBIgW4Br/PGHIrRBwOGaEy0yGjDeccbpAL7nAtllvFanM+UrKMWQt4+3B9TJJYC1
	C9TdNPkZx9pg==
X-Gm-Gg: ASbGncvJ2Tl+z1DrF8bjIzRqITV4thGddPPmzKfI7+vEda3nsG5/rIMdPvzgX2ixJNK
	fV/ibyrfKmmYR1XcfE5eor1NGa4umaVzYZ35acnpdZsitCRoMXjSIV2bQQKwXL243u+yoaX6Otk
	P4Ypy9tZzgQTwASN8CvOgoFjnHarXRUNtRJGdKBRIPnF97NwIzg7tZ1i0vAmgYrtuJV3hLMPP6i
	MLbe+pTQKdL14hVjVaXxcgVs0viZGJjY4533FRna2yejuIFK2pRPD5hL7y+eiwrfAal3vautazs
	ZZOzr/LyqhKjameYiMmoAa4VTUjmwpftlf5mdtsJftcjWea5tgrLHMuQSKd7h7yrCIIC/TT0oD/
	CjVAZ01ncAE9X62D9m5Ni3KBrWwJcH53M+QzrOQpDeYrm+jRjj0oaD/MhB0MVrYHB/d0Nh1Ag25
	Hnc40ahFThR6lWeAoCSwYapAY=
X-Received: by 2002:a05:6402:1467:b0:647:8d63:d8b4 with SMTP id 4fb4d7f45d1cf-6478d63d985mr1389519a12.6.1764676331226;
        Tue, 02 Dec 2025 03:52:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnMiVlmki0ogqB/rjjKmxYW241m0D9+1e4z7ydsRRIt5eGoAPCv4LFWTLrYgGpg63kI73JFw==
X-Received: by 2002:a05:6402:1467:b0:647:8d63:d8b4 with SMTP id 4fb4d7f45d1cf-6478d63d985mr1389506a12.6.1764676330801;
        Tue, 02 Dec 2025 03:52:10 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5702200011ee99ed0f378a51.dip0.t-ipconnect.de. [2003:cf:5702:2000:11ee:99ed:f37:8a51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm15206765a12.29.2025.12.02.03.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 03:52:10 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>
Subject: [PATCH v2 0/6] seccomp: support nested listeners
Date: Tue,  2 Dec 2025 12:51:52 +0100
Message-ID: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear friends,

this patch series adds support for nested seccomp listeners. It allows container
runtimes and other sandboxing software to install seccomp listeners on top of
existing ones, which is useful for nested LXC containers and other similar use-cases.

I decided to go with conservative approach and limit the maximum number of nested listeners
to 8 per seccomp filter chain (MAX_LISTENERS_PER_PATH). This is done to avoid dynamic memory
allocations in the very hot __seccomp_filter() function, where we use a preallocated static
array on the stack to track matched listeners. 8 nested listeners should be enough for
almost any practical scenarios.

Expecting potential discussions around this patch series, I'm going to present a talk
at LPC 2025 about the design and implementation details of this feature [1].

Git tree (based on for-next/seccomp):
v2: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v2
current: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners

Changelog for version 2:
- add some explanatory comments
- add RWB tags from Tycho Andersen (thanks, Tycho! ;) )
- CC-ed Aleksa as he might be interested in this stuff too

Links to previous versions:
v1: https://lore.kernel.org/all/20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v1

Link: https://lpc.events/event/19/contributions/2241/ [1]

Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>


Alexander Mikhalitsyn (6):
  seccomp: remove unused argument from seccomp_do_user_notification
  seccomp: prepare seccomp_run_filters() to support more than one
    listener
  seccomp: limit number of listeners in seccomp tree
  seccomp: handle multiple listeners case
  seccomp: relax has_duplicate_listeners check
  tools/testing/selftests/seccomp: test nested listeners

 .../userspace-api/seccomp_filter.rst          |   6 +
 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/seccomp.h                  |  13 +-
 kernel/seccomp.c                              | 116 +++++++++++--
 tools/include/uapi/linux/seccomp.h            |  13 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 162 ++++++++++++++++++
 6 files changed, 286 insertions(+), 27 deletions(-)

-- 
2.43.0


