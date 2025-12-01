Return-Path: <linux-kselftest+bounces-46791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9900C96A7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8903343BDD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8C305047;
	Mon,  1 Dec 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALzwo/A/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BD302CB4
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584932; cv=none; b=PshcsJ/B+disWjtlwTY0ZluNtXfPavpquHbgheQvcbQ6mJMOCWm3XHzcJeEiCLhGy6ycXFLwM66h6XC0P4Yn959PSQWHUkvRdr5lOLAocEAOk+JxXFt9s9ktBqg1pXxsSI4MDE5CNFVEomup2n58FtCe00oYgw3/dXGTl3P6sGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584932; c=relaxed/simple;
	bh=wWdXTf3PWwMEgee4xvskzWMHbq0aF33vkNM3dtLaIL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXLJlLnmckw3t8I638FU2WOXhAOOWL+aFqBnWTadqx0XYEUPuAUCdGKhvRNEP+ghEl6OQcDcPIqr17g5D8xWxFgC++lfelUlc6ynsjqS8+joSuY88qK43YDts0fcAAIggfcZEbXo016PJKKK2dwnsb6jErMa/9lJFAPtZFj3v50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALzwo/A/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b762de65c07so29462066b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584929; x=1765189729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIzSKOpGNcki0F1mAxWBRjW2MjoQZLx/rLT/pH+h1/4=;
        b=ALzwo/A/1oONJ4pDgmgfJxKYk+/KbSMZ47exwPvEuMdzn+gIuxGLa8Ox0DkRG19zn5
         IiavKdToIAEapOcOWnvFJEx5yt4uTtIC4sJwtyYC5PghA3GN3d3phCRrsZQOlAuoaX6f
         LJfsv2Pm/R8e9Jxk9lJYC6ofSg1jEI/xWK6KTyN5Btk9Z94yhoXmvN4PxI+TEvluSVW5
         a6Kad/EHKguuzwH5bVWtPcMERw3vbst2wmHySu/2OBYZ50KeyFhwK4XvrMfRR8R+4uUJ
         1irBPnCRVdLr/AmO8MInFJf977t4AyaerDIiZfJHOVC1POOCidwabNKpMlbRDEXswyxm
         Hy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584929; x=1765189729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIzSKOpGNcki0F1mAxWBRjW2MjoQZLx/rLT/pH+h1/4=;
        b=FNjfEnrYds7k7xkBDee23vMfO2BdugybZ1UG2gsePEGd+tclxe9IIKZK1kM5sVoO/R
         oPbhU9B9r3bapQzzmBo3XkJg6FM2Oep9gE4Le5cAM+PNsA3bIVPXXueIE+YsYnYpCL8M
         DYpUqCRKcBNWTsgD23A/HOJLpvq2IePrTupdkn4Zk0s70Y8CqpdaG0vKqruMm7mWysUY
         rhRhg21RJafOdImdJf87/zEcn6HSm/bqwi8irlQNbd2emsl4zNCi1jNZj/3hUnCi2H0a
         hFR3BMvxe4y0xodj6Ni5k2I8u7YQHpsk8HCp099cKj2Q7tz+sjxWPAHzteet8r6yy8GO
         AMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXwoUkLXzIDC1gedIm0T1wnX8dirrmFQZZNtrxxpDAMc4+0kCsKpgmQ6NuSsGnhIXYNhZoL3hzS9nGJF/cstHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvy4ap5iPJedSoMW6iIvDpeNjxemPpPbvYHhlSx8CXWOrZi02D
	w8mtFGRBFlPjQz/we6Q7bbV3NYM7C4EkkTpg562Wbn5xTMsh+dsHi2qF
X-Gm-Gg: ASbGncsS5TrtB5yF286Rilp2Ik7jI8EkNEh5lSSCYqNNfGbJHaYHNF6nz2rybaXVQT8
	oi1omd91hRhfWdB6oAjTMLZaYaD+/EnAMVqy/Vmi5VWL89yhHN7ZWHajNyZ8skhQgyrXUok9E0U
	sxF9yIYo+d6yF+r9a7xOMn3m6GfW7I1hMr087uFCTIIz1he4zHYDhmRsQpcYgEzAVoQUvsUAcBL
	Nv/UBKvbjkLny7YyfjLbjZnaMy1NmYTY7av0ta4jOOW7+EJRhBYi4N4fc9DoQzLdJzMNJIrEr2L
	22pT9kaDWI8zk7kVAY1qFAa7cbv2r4JuVulyJY7NzU/MBb4wbko1S4+7a7qwZu1p2jPSdAW4/2B
	uBp4e8r+orAwo5Zy2iHcSFIExD1sYoKHZtgBNAxpOQHVemrWj13urika9GxmkB/Giir7FRfNzZR
	T+GUaXypzn0y0MvxYrCInQNWbbafmVOc61JZpdHTEavFdAgN8GakWCYPm4x+3rFzJHAYk=
X-Google-Smtp-Source: AGHT+IG/MbOrMoxloIMO1QZgU+rp0yNg3TPBATPkNx5UeifGWcK6FmSaWpWZL8LEhuVo0rEEYcPgGg==
X-Received: by 2002:a17:906:f5a5:b0:b3f:f207:b748 with SMTP id a640c23a62f3a-b76c547167bmr2736230066b.10.1764584929180;
        Mon, 01 Dec 2025 02:28:49 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a3a4ebsm1178101966b.62.2025.12.01.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:48 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC/RFT net-next v2 2/5] net: dsa: deny multiple 8021q uppers on bridged ports for the same VLAN
Date: Mon,  1 Dec 2025 11:28:14 +0100
Message-ID: <20251201102817.301552-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201102817.301552-1-jonas.gorski@gmail.com>
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating 8021q uppers on bridged ports on a vlan filtering bridge,
we will configure the VLAN on the ports. For the dsa driver, there is no
difference between a 8021q upper on bridged port and a port vlan
configured within the bridge.

For that reason, if we configure a second 8021q upper for the same VLAN
on a different port of the bridge, we implicitly enable forwarding
between these ports on that VLAN.

This breaks the requirement for 8021q uppers for the VLAN to be
consumed, so we need to reject these configurations. Reuse
dsa_user_vlan_check_for_8021q_uppers() and change its argument to just
the vlan id.

Before:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link GbE1 type vlan id 100
$ ip link add swp2.100 link GbE2 type vlan id 100
$

After:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link GbE1 type vlan id 100
$ ip link add swp2.100 link GbE2 type vlan id 100
RTNETLINK answers: Resource busy

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* no changes

 net/dsa/user.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index fa1fe0f1493a..e8c6452780b0 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -653,8 +653,7 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
 
 /* Must be called under rcu_read_lock() */
 static int
-dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
-				     const struct switchdev_obj_port_vlan *vlan)
+dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp, u16 other_vid)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_port *other_dp;
@@ -674,7 +673,7 @@ dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
 				continue;
 
 			vid = vlan_dev_vlan_id(upper_dev);
-			if (vid == vlan->vid)
+			if (vid == other_vid)
 				return -EBUSY;
 		}
 	}
@@ -702,7 +701,7 @@ static int dsa_user_vlan_add(struct net_device *dev,
 	 */
 	if (br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
 		rcu_read_lock();
-		err = dsa_user_vlan_check_for_8021q_uppers(dp, vlan);
+		err = dsa_user_vlan_check_for_8021q_uppers(dp, vlan->vid);
 		rcu_read_unlock();
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
@@ -3185,6 +3184,16 @@ dsa_user_check_8021q_upper(struct net_device *dev,
 		return notifier_from_errno(-EBUSY);
 	}
 
+	rcu_read_lock();
+	err = dsa_user_vlan_check_for_8021q_uppers(dp, vid);
+	rcu_read_unlock();
+
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "This VLAN already has an upper configured on a bridge port");
+		return notifier_from_errno(err);
+	}
+
 	return NOTIFY_DONE;
 }
 
-- 
2.43.0


