Return-Path: <linux-kselftest+bounces-42261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E737BB9C5A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 00:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F54B3B951B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76F299AAA;
	Wed, 24 Sep 2025 22:25:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D596296BB2
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752724; cv=none; b=t8RV9CBfb6ODqF8An7bZqAfGtXQRn42uhKzVi0yVoaJjBknkTwysCayghPL5YcGWq0SqXyb9zfGJRYI9Hxzw7chx0/gJLIBinb4HTfB54PJK6la1sFu1fMiD5o2G05ri/IwtzkapC5bM3abtUofV7mM7HAtP1dk6lDkMKMiEmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752724; c=relaxed/simple;
	bh=WZFQ4QbS4tuIRsIHYIq1heNMZZWIkgtQ3sE2KKCJL7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlXzg92wHNn4fWwBAFopjepWQ2aPyJS20h01NCfBsBdL+sPsFq5kwYaohHOCkNDkA3Xl84XNmfDMsrW/F9wmZNZgkNyedyQB9f/g//ryRpLwjTO3eAaiKGYK90NbQcWL3xm2bX7KqUciI5PYAi+feC9HfGBdfao60nA1GMR7Zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f41086c11so412168b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 15:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758752720; x=1759357520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOxR1T/V0SqrOvtqSwQkNFCuPzO0g7fl8l2lrbsCB4U=;
        b=U/fB8hDtG1k3wiVqGgYIPzu8YjfxXlCHhd1H3UUD14RPq7jbgjvBIv+bXdtoNklpHG
         VJOAdVc+etV2dqxAY+/j9W5kZ4ukiBxhsI6uvFR6s2ZOyGkS9BXdDQTtKop3s5GFKDDU
         +PhyWeajKYyEfD6s35Do/eBivQBoVOVhWiDwdfdVYpln4x8JuXJ3xIi3Q4DtoM6IrmWH
         NvK+HgZ+nDlxacDCVaX28jK3jkSFAqkUbOsTbrzJZlL/vGnAGes/uLyYHS6hNFTEX5ml
         HM6QpPH0pPpicF5bYA0/5NIrF1cDPa3hCGAYXS0W7eCa2hmmaOcvlws0d87zYJOT1YXB
         a79g==
X-Forwarded-Encrypted: i=1; AJvYcCWxT1No33zSxxetOs4LIN+baBUaQJuRMcQ6qtl1zxb8gK+JIhy5YdEoK44bXD4o4hzsDt9pw+PvQaJmjfuR+m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzCJfVjkybfEgxRDaUyiyr0pN1LHmbJb1SEfWOVLawvhOGvI9
	AuhDmUYQ5CQ4hA9fBzYa+WEmXoZW/fRZkz4o1gJPkZ8ZdlcOpgVnc9Y=
X-Gm-Gg: ASbGnctQJFrpU/vjJXHf2+HM/10B4CAbdIDhx2UiiHQjZmeYueVkW7CanDC2Sj2A8/S
	eY2VPUL6zOk8rCOaF9RJFOO+j4OkAIxVB27lAGvmJSaqL5isopD3IjXsoK4jvSnEcWPlx+lu6Hh
	Tqr8y+KhG8UcHsswkOkz9N9sC/mo1JWS1ny+CtS49xZCmIGxIZIaOwD3jUDq993nZ1Ut/7Krxg+
	DE8rlP1q0ZAfksnrNxgd61kgzv8Wr01SFzoTXoh2KKthAPBFe/dbyA2rfuFIMRF1kOhkICrZPgj
	EESzLJ/qnPvJ/YrFmj0Mqs1pm5ZdTf12OD0JPRv+6YirjKjrsJ3fTCe4wrLwf5AdNHm1HF/8I5/
	EOBfQ/UsDs/42dp5wVpgUW9dEbfZ20eqfPyLmExhGruM75HinuVHNnPac0FPwrx6kooBiPIRdBJ
	VNpixb0DBnwMYNJWuJz3AAYx3zyLj8ibN5ik63kGtltsO/YTZt6C+gItFUJha48nj4+skGZ3X+5
	B+/ZWxs2RXtjXc=
X-Google-Smtp-Source: AGHT+IH39Y4AoWan18Zria3PfzUeTAXFMAr1O7HUFYefIPRhyAPFja93UNsI1NeluaQqtNNXWutFyA==
X-Received: by 2002:a17:903:3201:b0:264:a34c:c62 with SMTP id d9443c01a7336-27ed4affb23mr11790205ad.61.1758752719615;
        Wed, 24 Sep 2025 15:25:19 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3347224b6d0sm119663a91.11.2025.09.24.15.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:25:19 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: Enable BTF
Date: Wed, 24 Sep 2025 15:25:18 -0700
Message-ID: <20250924222518.1826863-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fec2e55bdef ("selftests: drv-net: Pull data before parsing headers")
added __ksym external symbol to xdp_native.bpf.c which now requires
a kernel with BTF. Enable BTF for driver selftests.

Before:

  # TAP version 13
  # 1..10
  # # Exception| Traceback (most recent call last):
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
  # # Exception|     case(*args)
  # # Exception|     ~~~~^^^^^^^
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 231, in test_xdp_native_pass_sb
  # # Exception|     _test_pass(cfg, bpf_info, 256)
  # # Exception|     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 209, in _test_pass
  # # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
  # # Exception|     cmd(
  # # Exception|     ~~~^
  # # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdpdrv obj {abs_path} sec {bpf_info.xdp_sec}",
  # # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  # # Exception|     shell=True
  # # Exception|     ^^^^^^^^^^
  # # Exception|     )
  # # Exception|     ^
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/utils.py", line 75, in __init__
  # # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
  # # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/utils.py", line 95, in process
  # # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
  # # Exception|                          (self.proc.args, stdout, stderr), self)
  # # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eni30773np1 mtu 1500 xdpdrv obj /home/sdf/src/linux/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp
  # # Exception| STDOUT: b''
  # # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find '.BTF' ELF section in /lib/modules/6.17.0-rc6-virtme/build/vmlinux\nlibbpf: failed to find valid kernel BTF\nlib
  bpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/home/sdf/src/linux/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
  # not ok 1 xdp.test_xdp_native_pass_sb
  ...

After:

  # TAP version 13
  # 1..10
  # ok 1 xdp.test_xdp_native_pass_sb
  # ok 2 xdp.test_xdp_native_pass_mb
  # ok 3 xdp.test_xdp_native_drop_sb
  # ok 4 xdp.test_xdp_native_drop_mb
  # ok 5 xdp.test_xdp_native_tx_sb
  # ok 6 xdp.test_xdp_native_tx_mb
  # # Ignoring SIGTERM (cnt: 2), already exiting...
  # # Ignoring SIGTERM (cnt: 3), already exiting...
  # # Exception| Traceback (most recent call last):
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
  # # Exception|     case(*args)
  # # Exception|     ~~~~^^^^^^^
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 506, in test_xdp_native_adjst_taa
  # # Exception|     res = _test_xdp_native_tail_adjst(
  # # Exception|         cfg,
  # # Exception|         pkt_sz_lst,
  # # Exception|         offset_lst,
  # # Exception|     )
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 467, in _test_xdp_native_tail_adt
  # # Exception|     recvd_str = _exchg_udp(cfg, port, test_str)
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 72, in _exchg_udp
  # # Exception|     with bkg(rx_udp_cmd, exit_wait=True) as nc:
  # # Exception|          ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/utils.py", line 137, in __exit__
  # # Exception|     return self.process(terminate=terminate, fail=self.check_fail)
  # # Exception|            ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/utils.py", line 85, in process
  # # Exception|     stdout, stderr = self.proc.communicate(timeout)
  # # Exception|                      ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^
  # # Exception|   File "/usr/lib/python3.13/subprocess.py", line 1222, in communicate
  # # Exception|     stdout, stderr = self._communicate(input, endtime, timeout)
  # # Exception|                      ~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
  # # Exception|   File "/usr/lib/python3.13/subprocess.py", line 2128, in _communicate
  # # Exception|     ready = selector.select(timeout)
  # # Exception|   File "/usr/lib/python3.13/selectors.py", line 398, in select
  # # Exception|     fd_event_list = self._selector.poll(timeout)
  # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/ksft.py", line 208, in _ksft_intr
  # # Exception|     raise KsftTerminate()
  # # Exception| net.lib.py.ksft.KsftTerminate
  # # Stopping tests due to KsftTerminate.
  # not ok 7 xdp.test_xdp_native_adjst_tail_grow_data
  # # Totals: pass:6 fail:1 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index f27172ddee0a..da5a5a94fa6a 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -5,3 +5,5 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_XDP_SOCKETS=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_BTF_MODULES=n
-- 
2.51.0


