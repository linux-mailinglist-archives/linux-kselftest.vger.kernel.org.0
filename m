Return-Path: <linux-kselftest+bounces-14938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDD94AF41
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDCD1F23283
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9613DDCC;
	Wed,  7 Aug 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNyN3Oz/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3312C530;
	Wed,  7 Aug 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053455; cv=none; b=falCwXjrKOr9NS4wScG1TE0dc187FI7yXkWS0to4DWoRBkZ2UchXYQxGBWEetK3oe8xn1b0ZMiECPlueqthcJI9Ij0VRd8PYF2a7GW/O9B0x2N5eErhSJGzPwLeY7L9l2dFYwZ4Xm/yBIY9Ac5iAs2xgwfgG3WcEYyOw17cSPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053455; c=relaxed/simple;
	bh=lxLP0j601D/ztBKqEc/z8/cxU/DXbnkgu7qajEkP7Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DquhbMVVouLKhKIU5GRLPHue06D3gcCrucos+dY26G0GEiyHrNWvJzJ5MlFmxxZrZu4biSZu6kcPzVerSVOdkXHy9YHDpEs6V08YWIyU3FL152/Iw6GGKi4CpQUugX+h0881WleU1MZAzHa8S8/ITejpch26SUGP/VdN3+YXxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNyN3Oz/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so83907a12.1;
        Wed, 07 Aug 2024 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053453; x=1723658253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yYjASZY7u1lbG43xh8z2noGsJjnIAbthCjb6jwKr/0=;
        b=ZNyN3Oz/a68WXkW41Y92iXg5CuAgkeLsInGxLm77JGBi3AbBMsIail7dDCaHY1CKgT
         ZyZLXQobBOXIohD/j/Z9X8dp989wE9I03jUkAD5ShncGIlMdk9qNH2wCgqKZ7iZlxwWI
         RTIsDDZqmdNBEbI7qtqOKqC5YL9RQ5UviIz1BPQtBnBCtA/UOkUagSq9KSxOWdlSBew2
         i0gSxsPbkCRRUYXrFpyy6ffevlRwf4f5omHY0n8KNNWYyF+Fvnljmbseqrcbo6ClfNK5
         7hKWiQvazwLX3cO70J4RyQ227ihQAOwgh8vpAnLZkGsgUeAop1An7k65AQjNc5aWYzon
         HdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053453; x=1723658253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yYjASZY7u1lbG43xh8z2noGsJjnIAbthCjb6jwKr/0=;
        b=ZTzQ9hw8NDugAyeW2jRX/LUCRIZZtC6dyBVOkfYmjfUyy8lmCCUfTjnIVSkGoQ6gjw
         qCktbMzjQd9O49ow/x215qZ8sv38nD/mIxciVEqitmeDpKsfonT6trvZD1B0vHU5Uvxw
         bryatqEtaWjhDtquiqU3u6H2GwPeMnhcix+cJp9QtJSD0+P9+uL/yx4wO5dENGKlZPei
         HvrQNoP6RcLtgS2XffYvuCZNhuK8E+w7CZhtCVQ7lHEUaT6foA3qKDBXv6cIzl5ThJux
         1CC+jq81fYuHASOBVchfEiYuNtlB+relkPM4B1ErgOKF0xxauAQ2lPyDG2o1Q4X47dMX
         rsNg==
X-Forwarded-Encrypted: i=1; AJvYcCX9VIQ0QYok2it9w06VV8SIdXa6mfztb/A0JquPLC4VYdUuMY7WFSk9xCQmXiHhr+SQl63eq0/KFNvsEBhfK8lUyCde13cpCZfmn59wlzLUT8U19L7I/uh7F12sKTZsSQe5KUn9nVj7ddITa7eHdwjycEecYHrjTzc3r5JEuTQ64uMBmB8V
X-Gm-Message-State: AOJu0YzqOOGc0AhnbZ0fHZ29YSpHZjCKhqnT5pYz9QQyPQC/oyP0V2Lc
	Qd4tC/ktYUpKl98oTy8OerGfqF8cGM4gKne9i6Wc5i9KinOg8AMdaNQp6iuH
X-Google-Smtp-Source: AGHT+IH/E7U58RpdbdF1A0RvJxRZExh3bUf8iWXzQlS7ASEaZ4efq5trOBnvNf+kDbwA0cFJ7sy9uQ==
X-Received: by 2002:a05:6a20:6f90:b0:1c0:f529:bad6 with SMTP id adf61e73a8af0-1c69964abcamr19949907637.45.1723053453068;
        Wed, 07 Aug 2024 10:57:33 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c211cf0726sm204429a12.16.2024.08.07.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:57:32 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v4 0/2] Enhance network interface feature testing
Date: Wed,  7 Aug 2024 17:57:15 +0000
Message-Id: <20240807175717.7775-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series includes fixes for creation of veth pairs for
networkless kernels & adds tests for turning the different network
interface features on and off in selftests/net/netdevice.sh script.

Changes in v4:
Move veth creation/removal to the main shell script.
Tested using vng on a networkless kernel and the script works, sample
output below the changes.

Changes in v3:
https://lore.kernel.org/all/20240614113240.41550-1-jain.abhinav177@gmail.com/

Add a check for netdev, create veth pair for testing.
Restore feature to its initial state.

Changes in v2:
https://lore.kernel.org/all/20240609132124.51683-1-jain.abhinav177@gmail.com/

Remove tail usage; use read to parse the features from temp file.

v1:
https://lore.kernel.org/all/20240606212714.27472-1-jain.abhinav177@gmail.com/

```
# selftests: net: netdevice.sh
# No valid network device found, creating veth pair
# PASS: veth0: set interface up
# PASS: veth0: set MAC address
# SKIP: veth0: set IP address
# PASS: veth0: ethtool list features
# PASS: veth0: Turned off feature: rx-checksumming
# PASS: veth0: Turned on feature: rx-checksumming
# PASS: veth0: Restore feature rx-checksumming to initial state on
# Actual changes:
# tx-checksum-ip-generic: off
# tx-tcp-segmentation: off [not requested]
....
....
....
# PASS: veth1: Restore feature tx-nocache-copy to initial state off
# PASS: veth1: Turned off feature: tx-vlan-stag-hw-insert
# PASS: veth1: Turned on feature: tx-vlan-stag-hw-insert
# PASS: veth1: Restore feature tx-vlan-stag-hw-insert to initial state on
# PASS: veth1: Turned off feature: rx-vlan-stag-hw-parse
# PASS: veth1: Turned on feature: rx-vlan-stag-hw-parse
# PASS: veth1: Restore feature rx-vlan-stag-hw-parse to initial state on
# PASS: veth1: Turned off feature: rx-gro-list
# PASS: veth1: Turned on feature: rx-gro-list
# PASS: veth1: Restore feature rx-gro-list to initial state off
# PASS: veth1: Turned off feature: rx-udp-gro-forwarding
# PASS: veth1: Turned on feature: rx-udp-gro-forwarding
# PASS: veth1: Restore feature rx-udp-gro-forwarding to initial state off
# Cannot get register dump: Operation not supported
# SKIP: veth1: ethtool dump not supported
# PASS: veth1: ethtool stats
# PASS: veth1: stop interface
# Removed veth pair
ok 12 selftests: net: netdevice.sh
```
Abhinav Jain (2):
  selftests: net: Create veth pair for testing in networkless kernel
  selftests: net: Add on/off checks for non-fixed features of interface

 tools/testing/selftests/net/netdevice.sh | 55 +++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

--
2.34.1


