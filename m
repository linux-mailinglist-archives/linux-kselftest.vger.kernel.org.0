Return-Path: <linux-kselftest+bounces-23464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E19F5689
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70A41892E72
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334A1F8EF4;
	Tue, 17 Dec 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWWfSqU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962011F8AD9;
	Tue, 17 Dec 2024 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461533; cv=none; b=kctprXMzzy8yO1IiYGXhmQs5EvwzSaPxzRsLdjNWSMmOZaeJ6ScrH3Pt9ffLdHhrJtpg2BLr0GJsPaFHzqJh/ZX/1kgBsmEaJj5BWQ/RiIlqn5reLz0zuTX5FvS9maHxJ/2ucAE16xdyvpOcBHvBEpYVElDPVGLO8l/i1R9K72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461533; c=relaxed/simple;
	bh=fo95pWf1fly65pEt23cIGpLHcplB/7M+vlG3Wr78zR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NHkvnME6z/hhjPJcFcgi0vb1Eogi7szNRpu2E4iJUj1UlHv/sSeoKvHcTQOJO5nUccZt7NM77y9SsbpoY+QvGYjF7OQRKu9tefgDH6unhrHqOQMynmHAA49cAFO+G1x7iUUPxixjoC5wB/2nhLTTrTBycrLKLLaR4fLTjLWuNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWWfSqU2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2167141dfa1so47429555ad.1;
        Tue, 17 Dec 2024 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461530; x=1735066330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd6pfr5FTks2S3PUFALuLl9OULUHtQOqlaPVNDf2ggQ=;
        b=bWWfSqU260Q8liO3n2Xn+P0qlU6ofKlFBsaPhiweL03ln360p+8lB1wmmmvTsXQCEN
         lk8PvAUPHXJ7Sj/MI89dYKz9xQ0UohNtNqXaxMRi5PZb6b1pDCteb0TKhpL7wO0t87Ey
         f4jQGwctSZja9FrhPpWAa9Tgr3OQjP6z+SMakqClsRe+8GrpMwMEHQScrtL4K6m5waUv
         9p8wkwcYzGGZMP6J7yLmoxi2/w4+PPmcM3afs8nkkDLKXhza3Ytn50Gsi1h4vzSOknch
         VQ7wLaH16fL6G0T5c+s3feMbhPCjqRtB/AZsaX4pUcuxKm35Dd4yiM1XYRHs+KhVOL5P
         UVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461530; x=1735066330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hd6pfr5FTks2S3PUFALuLl9OULUHtQOqlaPVNDf2ggQ=;
        b=KFZWMEXFD3Pf1Wa8BxTaXPWvVbTODpPR/9FlMYDR6b37WedzCiLOmBHU0puOi5C8zZ
         zL9u6Y0xyTRyBwlZv7tTvb1QLa/HBcR4BmxWiltTlqSbdP+DOEczPWdABjxw/+CFQqBF
         9M3RCtd+J2jmUzPm0sDSiXo8leWF1kQxqfkEMS4BHVrRKeK83EiAJ/LW+Ya0oPhBQsK5
         GfRv5nOPudm1ne0YpGJLLZ1je4/2RpF7bEGeCGIo04vlz91mmGA8ieX4g1UKAMUE7GYi
         m1Z9hwzqXVaUwMaV7KenOmZUzTlCJ+iGOV2k3kg9z+I4KSgUIcjtIQXMIwV92sRf1SWm
         ksGw==
X-Forwarded-Encrypted: i=1; AJvYcCXgMszyNpXS/KgdoVrDlXGneJfvytM9m+Rm0I0P2OoAl61hsOfzwBQ8A9uNZbb9ZjgAVnmb0Osnhxnqk/Vhw1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYFTUVZo7xdilU1OMMBwat5oWg72TYzYmdCUZA/iwl0GmsGWW
	2FD/uy0ZlPbGWRPxxVvMKal2oy1QWWsrvJP6VRe/MwjLa9IVkHwrI+RNa3ZjUko=
X-Gm-Gg: ASbGnctHF4TQQ9LguMTx26I83B0o64E2Qm9++eV042yNp6fTpDPi2z5n4QDt7q1gAKY
	1CBRarqWgZmNBMR5yYNpcaqxZtk/wHjNIxp2tv+AjTetmCnjZr+OVnGQ/U6a9EYls7HU7w9b6+M
	jul6JXlzmwwrVgkrCHw+aTJOyVzEFVV859g0EaEj1LoxOzh+STpBN/vj5sxXbaKKsWY8oFRl5kW
	iPXg8tXmdv56cF9RQ6cgY/OElFY0WIBYAkP3hmn5wNhSYHGguOTo/5zkFC031FJRNvHk/kEWqK5
	8lovfVV7f+KvfQAVqdQs+rbgJMcuKO+aAG7GcQD+WJa6yjiKxGFng/FERQ==
X-Google-Smtp-Source: AGHT+IF5duTkePT7yPEaDf18fW+zG2s3TZ6MDQVwork/gG5iaNPxE01/hWC2pbhp9twoZDhWv+SjvQ==
X-Received: by 2002:a17:902:d2cf:b0:215:a303:24e9 with SMTP id d9443c01a7336-218c91fce95mr59803335ad.3.1734461530459;
        Tue, 17 Dec 2024 10:52:10 -0800 (PST)
Received: from sohamch-kvm.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dbb079sm62307715ad.31.2024.12.17.10.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:52:09 -0800 (PST)
From: Soham Chakradeo <sohamch.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Soham Chakradeo <sohamch@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple tests
Date: Tue, 17 Dec 2024 18:51:57 +0000
Message-ID: <20241217185203.297935-1-sohamch.kernel@gmail.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Soham Chakradeo <sohamch@google.com>

Import tests for the following features (folder names in brackets):
ECN (ecn) : RFC 3168
Close (close) : RFC 9293
TCP_INFO (tcp_info) : RFC 9293
Fast recovery (fast_recovery) : RFC 5681
Timestamping (timestamping) : RFC 1323
Nagle (nagle) : RFC 896
Selective Acknowledgments (sack) : RFC 2018
Recent Timestamp (ts_recent) : RFC 1323
Send file (sendfile)
Syscall bad arg (syscall_bad_arg)
Validate (validate)
Blocking (blocking)
Splice (splice)
End of record (eor)
Limited transmit (limited_transmit)

Procedure to import and test the packetdrill tests into upstream linux
is explained in the first patch of this series

These tests have many authors. We only import them here from
github.com/google/packetdrill. Thanks to the following authors fo their
contributions over the years to these tests: Neal Cardwell, Shuo Chen,
Yuchung Cheng, Jerry Chu, Eric Dumazet, Luke Hsiao, Priyaranjan Jha,
Chonggang Li, Tanner Love, John Sperbeck, Wei Wang and Maciej
Żenczykowski. For more info see the original github commits, such as
https://github.com/google/packetdrill/commit/8229c94928ac.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Soham Chakradeo <sohamch@google.com>

Soham Chakradeo (4):
  selftests/net: packetdrill: import tcp/ecn , tcp/close , tcp/sack ,
    tcp/tcp_info
  selftests/net: packetdrill: import tcp/fast_recovery , tcp/nagle ,
    tcp/timestamping
  selftests/net: packetdrill: import tcp/eor , tcp/splice ,
    tcp/ts_recent , tcp/blocking
  selftests/net: packetdrill: import tcp/user_timeout , tcp/validate ,
    tcp/sendfile , tcp/limited-transmit , tcp/syscall_bad_arg

 .../tcp_blocking_blocking-accept.pkt          |  18 +++
 .../tcp_blocking_blocking-connect.pkt         |  13 ++
 .../tcp_blocking_blocking-read.pkt            |  29 ++++
 .../tcp_blocking_blocking-write.pkt           |  35 +++++
 ...lose_close-local-close-then-remote-fin.pkt |  23 +++
 .../tcp_close_close-on-syn-sent.pkt           |  21 +++
 .../tcp_close_close-remote-fin-then-close.pkt |  36 +++++
 .../net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt |  21 +++
 .../packetdrill/tcp_eor_no-coalesce-large.pkt |  38 +++++
 .../tcp_eor_no-coalesce-retrans.pkt           |  72 +++++++++
 .../packetdrill/tcp_eor_no-coalesce-small.pkt |  36 +++++
 .../tcp_eor_no-coalesce-subsequent.pkt        |  66 ++++++++
 .../tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt |  72 +++++++++
 ...t_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt |  50 ++++++
 ...tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt |  43 ++++++
 ...ecovery_prr-ss-ack-below-snd_una-cubic.pkt |  41 +++++
 ...ited_transmit_limited-transmit-no-sack.pkt |  53 +++++++
 ...limited_transmit_limited-transmit-sack.pkt |  50 ++++++
 .../packetdrill/tcp_nagle_https_client.pkt    |  40 +++++
 .../tcp_nagle_sendmsg_msg_more.pkt            |  66 ++++++++
 .../tcp_nagle_sockopt_cork_nodelay.pkt        |  43 ++++++
 .../tcp_sack_sack-route-refresh-ip-tos.pkt    |  37 +++++
 ...ack_sack-shift-sacked-2-6-8-3-9-nofack.pkt |  64 ++++++++
 ..._sack_sack-shift-sacked-7-3-4-8-9-fack.pkt |  66 ++++++++
 ..._sack_sack-shift-sacked-7-5-6-8-9-fack.pkt |  62 ++++++++
 .../tcp_sendfile_sendfile-simple.pkt          |  26 ++++
 .../tcp_splice_tcp_splice_loop_test.pkt       |  20 +++
 ...scall_bad_arg_fastopen-invalid-buf-ptr.pkt |  42 +++++
 .../tcp_syscall_bad_arg_sendmsg-empty-iov.pkt |  31 ++++
 ...yscall_bad_arg_syscall-invalid-buf-ptr.pkt |  25 +++
 .../tcp_tcp_info_tcp-info-last_data_recv.pkt  |  21 +++
 .../tcp_tcp_info_tcp-info-rwnd-limited.pkt    |  54 +++++++
 .../tcp_tcp_info_tcp-info-sndbuf-limited.pkt  |  39 +++++
 ...tcp_timestamping_client-only-last-byte.pkt |  92 +++++++++++
 .../packetdrill/tcp_timestamping_partial.pkt  |  91 +++++++++++
 .../packetdrill/tcp_timestamping_server.pkt   | 145 ++++++++++++++++++
 .../packetdrill/tcp_ts_recent_fin_tsval.pkt   |  23 +++
 .../packetdrill/tcp_ts_recent_invalid_ack.pkt |  25 +++
 .../packetdrill/tcp_ts_recent_reset_tsval.pkt |  25 +++
 .../tcp_user_timeout_user-timeout-probe.pkt   |  37 +++++
 .../tcp_user_timeout_user_timeout.pkt         |  33 ++++
 ...validate_validate-established-no-flags.pkt |  24 +++
 42 files changed, 1848 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-write.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-local-close-then-remote-fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-on-syn-sent.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-remote-fin-then-close.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-large.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-retrans.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-small.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-subsequent.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-ack-below-snd_una-cubic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-no-sack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-sack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_https_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_sendmsg_msg_more.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_sockopt_cork_nodelay.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-route-refresh-ip-tos.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-2-6-8-3-9-nofack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-3-4-8-9-fack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-5-6-8-9-fack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sendfile_sendfile-simple.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_splice_tcp_splice_loop_test.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_syscall-invalid-buf-ptr.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-last_data_recv.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-rwnd-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-sndbuf-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_client-only-last-byte.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_partial.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_fin_tsval.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_invalid_ack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_reset_tsval.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_user_timeout_user_timeout.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_validate_validate-established-no-flags.pkt

-- 
2.47.0.338.g60cca15819-goog

