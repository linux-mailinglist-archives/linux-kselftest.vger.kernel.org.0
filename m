Return-Path: <linux-kselftest+bounces-46790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D1C96A69
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F8F3A277C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E53304BC9;
	Mon,  1 Dec 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX7nVxrr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6D303A34
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584932; cv=none; b=Ou0ikRpN73o28ok6MY9cuRnQlD+p8+66xLiEIxM42WxZ+pS05+Wl6KC6LIRScOvJTU3IGHz6htnItwJkt13bhVO9n4DqWKyN7A1FQ5udSmPWA4h3Mzm9nX8V8yImOv/KW9YMbXpVLrGC1iremePyi6mqctNhKwYYn2vQ2Uc3o+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584932; c=relaxed/simple;
	bh=a3FBgtBNu3mvlspy/DoRDK+WbOfe+joC26J0DWtMtFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OByjNvylPWfxGp0E6vtRnfq/ppqPlom5cQyOUn8BhDnQxHcmBusXOwd8ucg8MHllLqCsOKtitnruePBf5gF0q60oxjQCEv2O9DNxozo21uBMWGb6i6HUoZXt6536DRSwX99LebC6mXhlHM0sCuqkurKq+Xvhdl+1jaCkoWvrkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX7nVxrr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7355f6ef12so795909266b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584928; x=1765189728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzbSHnmLm2HKogqw9fcglsbW3IjBMhBVe0507gsTSHg=;
        b=iX7nVxrryiboy6afSVSpifeP4vJJFMlC2PoJv3sDadPIqBOJlfZb9ode7dBzSpA7iD
         KG5hKaIr074C+mFO6+aVsYycSOjqojVGbB4WqhpdB0skaVeX1CJ38NqqXARVCHROv29C
         VUZouHzcpJMY54QkSuKN/9ubvN9S3pz0g7hakEBOluMcoVe4lMsWu0XxXQz45lFGCXlb
         NTI1+Ux9xWV/Ens8nOopHJmQJ3aJRMOqtkZAPSOVBkZacbO/WlbstBA490mW8DTW5W2o
         PYQ/6UatEZMxr/w9741kXIVwbknVU1EkDYzA44kPmbHBwLrk1UR95dcPDtmFUhhJu4LJ
         2SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584928; x=1765189728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VzbSHnmLm2HKogqw9fcglsbW3IjBMhBVe0507gsTSHg=;
        b=aMO4PIDcAmmvPBHyy5FenGq51oE6eG+OgZroosCZp3+Lp3IW4nQSmfKAeubDYSlxum
         V7cnCP2cEQIWDjWDfry2N3Xx/MbWDvPSCowxce8Kkj1v3jfQfdXfu4d23tjGusVC1YIH
         GRXqzCGkhBA0gED9IOesdttoQTFkS2shIoVCmLOwyxVN05jP5MycqLAS4d8sp/FmM6iv
         66u4yOIQMWQMbqOrZc5wtmXH3Z2L972Va9BKxqR0tp/7EQyPfq71EogsnYZNzs50USn/
         xQsHC/aUjnqnGDj2jkvekBA3B5CWksyCbSzBGlTGnkmws7//CP1DfbJ7IFqX8gCCdw9R
         utwA==
X-Forwarded-Encrypted: i=1; AJvYcCUpqyRsUJgLyfUoLdewCPE97c0dW588PsgcIyE87y+8qR8rNouknfffLdI87Zo4jPlYJ1/+eHHILHjDmpTcHZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVrK0xgumAW1gUe7gPNhKdk43pKtf6Vl1r3GGoZFC0aYDL8IRb
	RHh6CMPh0DAAX52LXvVvGuHAxgChstpcREAI1KwlnDTM6us5L/AYcKpk
X-Gm-Gg: ASbGncv6eE5+FdemIBxamudoVQuo6xX4Euly6QxBr04JZnipa1MbaMBNxUrPil8u0NE
	dvsyru1o//xVoZbKZM13vtnMitYLp+6ccXxDAf+Ytn0/YJHo3G5mXU4Na38WMFrYJnG/sNzm/fz
	LvkTry869qDw3QRsiLnVHeUOxeWznJ+n33bcApjAXxeNOCA/1JSt9hKLwSgDTcQlQBOsiKB3KuG
	AG8LGepW2KHIiwRUMGs4LOs08TdpDOlPmIpwJ7hK8ANg93LnpujwwMc3CFGrVj/BUv1/emco3Pi
	e82rB8DpYdFVHGKJPgZW0OnxcPhpn38qTSDxqbCf3JAkHBZGtD4xM2EC3fmRY9RZXuddXi6gzmI
	EhR7WfBRg+Z8CM8KhXdfjqRqmk2e7iMwgi+CerDU9FomAhVOziqRxtaIE2b7bE0iKDeyw2W9WcH
	SzcwjrCq8nvHxuJAhtt6jxK10ps1sPRZ8H9EsKaXQDv15Wsfjsxne3+rOywaS4u1+gQhY=
X-Google-Smtp-Source: AGHT+IE7v6ceIh3pd4soCp8xqz/i5/FM9hHMZS3MRN9QRptYtUlF/PiDHzWEl0q3hZieNC6J05UC8Q==
X-Received: by 2002:a17:907:97d6:b0:b73:8f33:eed3 with SMTP id a640c23a62f3a-b76715afc72mr4333301466b.26.1764584927957;
        Mon, 01 Dec 2025 02:28:47 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647509896d1sm12520131a12.0.2025.12.01.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:47 -0800 (PST)
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
Subject: [PATCH RFC/RFT net-next v2 1/5] net: dsa: deny bridge VLAN with existing 8021q upper on any port
Date: Mon,  1 Dec 2025 11:28:13 +0100
Message-ID: <20251201102817.301552-2-jonas.gorski@gmail.com>
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

Currently adding a bridge vlan to a port only checks for an 8021q upper
of that vlan on the port, but does not check for matching 8021q uppers
on other ports.

This leads to the possibility of configuring shared vlans on ports after
adding uppers.

E.g. adding the upper after configuring the vlan would be rejected

$ ip link add br0 type bridge vlan filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ bridge vlan add dev swp2 vid 100
$ ip link add swp1.100 link swp1 type vlan id 100
RTNETLINK answers: Resource busy

But the other way around would currently be accepted:

$ ip link add br0 type bridge vlan filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link swp1 type vlan id 100
$ bridge vlan add dev swp2 vid 100
$ bridge vlan
port              vlan-id
swp2              1 PVID Egress Untagged
                  100
swp1              1 PVID Egress Untagged
br0               1 PVID Egress Untagged

Fix this by checking all members of the bridge for a matching vlan
upper, and not the port itself.

After:

$ ip link add br0 type bridge vlan filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link swp1 type vlan id 100
$ bridge vlan add dev swp2 vid 100
RTNETLINK answers: Resource busy

Fixes: 1ce39f0ee8da ("net: dsa: convert denying bridge VLAN with existing 8021q upper to PRECHANGEUPPER")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* no changes

 net/dsa/user.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..fa1fe0f1493a 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -653,21 +653,30 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
 
 /* Must be called under rcu_read_lock() */
 static int
-dsa_user_vlan_check_for_8021q_uppers(struct net_device *user,
+dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
 				     const struct switchdev_obj_port_vlan *vlan)
 {
-	struct net_device *upper_dev;
-	struct list_head *iter;
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_port *other_dp;
 
-	netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
-		u16 vid;
+	dsa_switch_for_each_user_port(other_dp, ds) {
+		struct net_device *user = other_dp->user;
+		struct net_device *upper_dev;
+		struct list_head *iter;
 
-		if (!is_vlan_dev(upper_dev))
+		if (!dsa_port_bridge_same(dp, other_dp))
 			continue;
 
-		vid = vlan_dev_vlan_id(upper_dev);
-		if (vid == vlan->vid)
-			return -EBUSY;
+		netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
+			u16 vid;
+
+			if (!is_vlan_dev(upper_dev))
+				continue;
+
+			vid = vlan_dev_vlan_id(upper_dev);
+			if (vid == vlan->vid)
+				return -EBUSY;
+		}
 	}
 
 	return 0;
@@ -693,11 +702,11 @@ static int dsa_user_vlan_add(struct net_device *dev,
 	 */
 	if (br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
 		rcu_read_lock();
-		err = dsa_user_vlan_check_for_8021q_uppers(dev, vlan);
+		err = dsa_user_vlan_check_for_8021q_uppers(dp, vlan);
 		rcu_read_unlock();
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Port already has a VLAN upper with this VID");
+					   "This VLAN already has an upper configured on a bridge port");
 			return err;
 		}
 	}
-- 
2.43.0


