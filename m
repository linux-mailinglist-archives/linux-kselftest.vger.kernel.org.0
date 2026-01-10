Return-Path: <linux-kselftest+bounces-48642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13900D0CA8D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230E33038023
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410C21423C;
	Sat, 10 Jan 2026 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/nWOLNj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16DD20C463;
	Sat, 10 Jan 2026 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006299; cv=none; b=UIMmGSHopi+EznoRQQH941HZnW9gjW46d2ogSS2vZe7/2MqiVD96Gg8EKno6fumkA1GqHBUxWQDj2hPpx1qmqjLT6/ao5kU6pY11yXNDAysuuNpsFtkaSWzlrA/074Brg3mEfAyVxAmCQuYV12HtUYNZGjIjCC6R+mYyLIEmlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006299; c=relaxed/simple;
	bh=dWVGugC0tE55cnQl16ySMZ4zv7y42Cy6+WZvC90Jb8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QExwOpW5O84VZdwINkJnff2eiu5JwodPZ2g7cFJ6p0nHkhXvyXK+parvn5Q9BmdmGtpexe83vFdBbYnWv0dJm6VkedJHh3vmpXXc9GG+MMtJkccqc/URT0631RFMNhD14QnOhDLVLHTUE9BX1V/nAEksADT2RwYMiMLqjMuJ7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/nWOLNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D075C2BC86;
	Sat, 10 Jan 2026 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006299;
	bh=dWVGugC0tE55cnQl16ySMZ4zv7y42Cy6+WZvC90Jb8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/nWOLNjpS+UXUsBDvSeBBdar4K1EZPtRWoIJ3trSdHLckvUvmvDNObPi37wiX9Db
	 p/KOAMfG+ifADAOdx7MI7CI67+Wu2efnsEUhK3Uw0QVdHBHnT1btN4XIJv21NNCINL
	 VlyaAVsQjko+EKhDtf3XMSfDOGvwXfkTT10sK7O7R+T1m3Q+1NUycFFGAq7tjrbvfD
	 jSf0JwvyOH6aCTd4WQGJkKHJl2k2gJZzx16B4RzpXr2KKtOyMGefFLLCrw+C+Jz5za
	 5RT1QxR/cb/bmvrAemmnE5aqoOHb2sYQps9/Ek8Lla5cgAl5QBT+LrYeePf60LOZw3
	 c47pHhuBEc+pw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/6] selftests: net: py: teach cmd() how to print itself
Date: Fri,  9 Jan 2026 16:51:17 -0800
Message-ID: <20260110005121.3561437-3-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110005121.3561437-1-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach cmd() how to print itself, to make debug prints easier.
Example output (leading # due to ksft_pr()):

  # CMD: /root/ksft-net-drv/drivers/net/gro
  #   EXIT: 1
  #   STDOUT: ipv6 with ext header does coalesce:
  #   STDERR: Expected {200 }, Total 1 packets
  #           Received {100 [!=200]100 [!=0]}, Total 2 packets.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 106ee1f2df86..881a17fbb5fd 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -41,7 +41,9 @@ import time
         self.ret = None
         self.ksft_term_fd = None
 
+        self.host = host
         self.comm = comm
+
         if host:
             self.proc = host.cmd(comm)
         else:
@@ -99,6 +101,27 @@ import time
             raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
                                  (self.proc.args, stdout, stderr), self)
 
+    def __repr__(self):
+        def str_fmt(name, s):
+            name += ': '
+            return (name + s.strip().replace('\n', '\n' + ' ' * len(name)))
+
+        ret = "CMD"
+        if self.host:
+            ret += "[remote]"
+        if self.ret is None:
+            ret += f" (unterminated): {self.comm}\n"
+        elif self.ret == 0:
+            ret += f" (success): {self.comm}\n"
+        else:
+            ret += f": {self.comm}\n"
+            ret += f"  EXIT: {self.ret}\n"
+        if self.stdout:
+            ret += str_fmt("  STDOUT", self.stdout) + "\n"
+        if self.stderr:
+            ret += str_fmt("  STDERR", self.stderr) + "\n"
+        return ret.strip()
+
 
 class bkg(cmd):
     """
-- 
2.52.0


