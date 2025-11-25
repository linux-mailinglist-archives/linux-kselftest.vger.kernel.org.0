Return-Path: <linux-kselftest+bounces-46423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C4C84C2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7B3B1AF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D9314D3B;
	Tue, 25 Nov 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MNqzmWEK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic314-19.consmr.mail.gq1.yahoo.com (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB227603C
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070648; cv=none; b=Blvg+HiZFjVzKeSCDRbNBoxn3q1mxOCsMTjY73S4rrA3ypNHDWSaI1IRmiS2Dv97TTZvfy3k9fbLv7zqLJNnbcUD8MNuToq6ypT/yiA1TtEBHOFDOdBgtPqAC7XjrRyHc4HDeavU5YwFOV6CYPFMv1vC9OX02iwon5HB+FIGI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070648; c=relaxed/simple;
	bh=n68/8w8Vz20Pp7RS6P80VVfiPvTaaD6DyXSzFNVk4VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=sS81v4cSs3k9Tzo2z+psvdg4O66ZIgS7zweKB++gwGEtQ4ib5RUopwEo4Ku3P7eirqCvhkxmPLIDrgyWYvn9wGQxeRo5kEvnoW0XbpAXXzqz01f2Sp4cTklT5Q12i66h5oPMJcXzAVXIk8aJxNxlHNBWm8ToNfeHx3pieyBaTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MNqzmWEK; arc=none smtp.client-ip=98.137.69.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764070639; bh=Aivk+Xo6Ed+LL8ift0X6oFeNEKF6SQ/3fN2hlA4qTb8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=MNqzmWEK/q73jLCEKQAMEd+GvwSuv80XiT96FndQvrKQf3IoTgSTx7JxMLmqkUDkEmbGBMAKxtjlJOieJ0Ev86Pkz7zjaRp7VOMXggAilYFuolRFFziB8FrJDm/9suEJ1uqGqgrcF+7VwLL1UpDdLCpYwEzrzg+tjoqkpuT56HjPn6bTKHtV+ZAJad7pfYaOHE/rC6tiuNoIrDZhkMokMQkZyLYgQSpptpG5jnn9KLjPKrTJ5p84wWMSpB1dQyAHqPASwDuTyh2lv/uIPwSXKepWXZi4tVoUlsp1iBQyCNZubSl3GfaKbO6FcESwO8xNY6KzptI6evIX+ATHdTqadA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764070639; bh=nzXBr8OLxgaTEOBnGkv1RZyFCpDhL83qLIW9S/cSD8s=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aaQQ3nryrSRy7w5acxHCG8RaPCoYQFFYaXOW9YtcVooAGRVjMIuvlAmjRBBVftY8KbtMPAMx3Ex6PpneG55/tOyDgDc5JhwmGwQ4JLS3u7ezDDk7TQsStZycM23KD/gQywSVvbHxtEe7Yu4ZJiSGAN8FxCDAnbbIldlHAztrtU1GFpxD61baV0nIb+xpMcEITnAP8NxXwO3RGsyVn0lAH8vHGYLKb+kEoYysZx6rUxxBemvz7JhJLtvBxCkyEHLzF2+r4HSYn7YDAL0lP3UJ0y6awfHorKpGM8KfMjBfkGI4n/85vymhJeATsdDCAIS17PV3PZ5k4wlrpGOyLqB2tA==
X-YMail-OSG: bkMrI3kVM1ksCYSAUFvOhW4xkjY.xGI.0niUTFdJjVedBCD9HvVKbN02GhYm4mi
 CiWUz4ltD0WSGHuOCep2mk4shieKcH1QtVSe4zpCbTpheR89TPSiiLRubW9wvHAWIud5gHb0z4eM
 p24Ejo.OE8ZG96WK3VraGRHSUFVmw_ZNewrJ0q53Pwi60AyktJDd8TLLAbTFimfXspXLjvFzN8cG
 Cg.SBriBPKA9scWcAec2opADkVXYzgwrFiw1cYVc.pjPCbh_jWn7aiXQ5Qmz_ftTwlFhevmqaGxo
 bAgQ0GyrLY15E8xwcQn3YsMz.dWV9Gf5pjruFlj233ganeExsI3Xr1jg9jsdIJLJDYYl4r_O9q7G
 gI6fG.dU6YvxSSMo4ptAfaxnnMjblbu5105DD27Sm4QU14B0.Aa0PdTr5qt2nBy0GMq6qigV2e1g
 UgvH30V2oQUTkWDWdWqGqtA.PQymgMcZQJW7PS1PPfY5QU5Z0_.ieu76d.iRaDaI34F7Y6Yjt9DB
 c.IWGMmZ2JCf4NxM455cqgjkYradUvNjx_Blm7K6RUvrQigA4SmJ7sR7TPVIEj6kNzAJSOH3QCrx
 g3R3rrEhOb4sd6M6okmrnzqSjWE6OqQ8i1pxMw2wh68pp_xaZnOUAm1w4vP1xj_QeUAD6IZhv0IX
 Ic5BVILX9XzIE_Ro7oeGEjtq_IujzNilEe7nY5EjW.E4kJr1h8O1g3U35CKBxFIDZi4Umh4EnEkq
 E3eK8gikJ_4SuLpTijoEjmy5kImjBKiW6HOkfn538pZOUWGGU1C6g0LcZ45Udk7PQWAqZRvU3jCI
 46iO2jd.PIfBDaUF9Rzhzhiujwz6d8vKfLtZzMBsaF2QWnyvyzJqho017iFtkcfXw2m4owWz4L_w
 5v5n2w8AiUXSCcI.kxji_ji3mUJfzLjPi3854_UfpoypSxschemc_4bHTbWAjQ0B8pgEnrWaCCpT
 mN9qR.Z.63Xnqm8OeyH6s6MIc4VKMOwfIDm5o2DduvX4iVF6zhjePkmJ.WKfJqicVi1keUQChMnT
 gSXGiF._mM4m5ZG25QhOvfnc7VQVdkIsJYDmFr7WSrZyGH_.75oa4xDpM42t88Xpdv0dmHFpvjDw
 rIf3AHI.le5ZPR.9Z.0M7vPA7yCf6whVJim6o1Ecmbw82zBrZZ_uw_lE25Gvhw7iZHYs_tLRkfU1
 p049LeXuPHy5J1OCoOX9VhRCgBiYAMI4m3KGm25m2DVzilqsF9fYj3K2JMZqoRTdf.Stq5hOlBDB
 XV_RICceDEdpHroLpbd7CflysF61gG8TnUmS2YsigdeXAyMJlGAcDbIMFKvi0ygxpsAaO_mCTeMg
 jrlDpgVFWWY60S3VVLnMfmx4RtGYB1XySwFA3cWWDtgN2IruaKDtNCQjoAHmwwVUxA7NzA8PWAU1
 RZj0.atMh04OGDnsiV1S8Z3EyACUmAUYCIC.GSFMYCbH4kbZ8kszEjWozrlCg8ZxWfRs2_7NGvlY
 iyEzBMKrNaJwpPhwqxPyYKTjJyrXF8ktmuarFuLj5YLDLH6nYVh9d5sQKjwBgak9ykMSCITafE.s
 6fuxLUAXi.Ovd6bKF8m04hZaA48j2OzNKY_i02gTBSmct_VsR0_E23fj.1M_8O5lL7nMcN91wPTS
 y31ApcHp02cSfl5odpdDT98GK7UwTtGHweuxu_O1NISNTlZ1cIkPlEHTVUOKqjAVPX_8Y8hYJU8o
 bS1duhjQ1VY.HstIRnef.0bjjPsFpc_WN3X.FWdD0vx.sHnv3caxAxz1TxapmytvFIakAZT8IXG0
 ywE8fTiaJuP2t7.t5II6x1HL7KOciHyGXLFK.OH7_oMxX3b5DjwNm1AIWUCD2jQxouUqFJ8vg0SE
 nJ46C_FxXo3HNPJSMWZrKqxBb..IAYD2SOdmEal88MvMCST1L_doisnl4FMHcct0rCieaw14i.So
 49NLgAmNLZFgcAr_Boc2_ifkpEd0DgLjJOWcTVWw3ZGUoarvN_cMqtF2JfQgm7OA4kl1opZmuYZ.
 LeUFLEcJnU4e7nuiygLKL_ioE3zfpxNLQZCX_kOpwdpDTT8cven2UOXbiG8tV.cMjy43yKlhTEWm
 q4t85p8ycJrc1ZIXWX1SVreq6HCUtsRaRdK4DVkyPtF.fU8pD3p3GkmqHAZxAaUT7xTHyPlOghya
 1ImxLLm0MxdAC1jQtc8wVhhRR2O3QLf6BpR_xYPR.o15QRwr6YKizz8qyIlngN481NaD73a8_QvL
 KWhDNqSYEs5OQeE6Suqn5ZAfoXuAF3YkCh7tqD2FcGF1R2ppheQ1Erc7UsT1x8VY_OU6Lbc52KLI
 y2HqxrCXbz5eo6eELLOUPPjhW
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: dd081103-3322-4c45-bd93-39a5a0a3f307
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Tue, 25 Nov 2025 11:37:19 +0000
Received: by hermes--production-bf1-694dc9467b-bgdsm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b98e5df8cac04b0f1d435e78fb7b22a3;
          Tue, 25 Nov 2025 11:37:16 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	oe-kbuild-all@lists.linux.dev,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next] selftests: af_unix: remove unused stdlib.h include
Date: Tue, 25 Nov 2025 12:36:48 +0100
Message-ID: <20251125113648.25903-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251125113648.25903-1-adelodunolaoluwa.ref@yahoo.com>

The unix_connreset.c test included <stdlib.h>, but no symbol from that
header is used. This causes a fatal build error under certain
linux-next configurations where stdlib.h is not available.

Remove the unused include to fix the build.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202511221800.hcgCKvVa-lkp@intel.com/
Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 tools/testing/selftests/net/af_unix/unix_connreset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
index bffef2b54bfd..9844e829aed5 100644
--- a/tools/testing/selftests/net/af_unix/unix_connreset.c
+++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
@@ -14,7 +14,6 @@
  */
 
 #define _GNU_SOURCE
-#include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
-- 
2.43.0


