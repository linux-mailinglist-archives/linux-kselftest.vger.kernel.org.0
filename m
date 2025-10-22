Return-Path: <linux-kselftest+bounces-43786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE0BFDD88
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35133ACF84
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E734B67F;
	Wed, 22 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iLQy8yaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9B34A784;
	Wed, 22 Oct 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157686; cv=none; b=A9YdtC6V5zeV+YQrIr6JhkSCWOasceA+U1C6N3avHKEFgQqT8zuHWerG84bbX/F2qOVwbrlmhJzGNZol7tY4+GVdEdS2kZCKdPcc27mlNvfse+tlW8q8YmjLJtuIR0Ea5qDajIvVYPvMGBQcAC3uos7zBGIZLH2R10eCB8CNo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157686; c=relaxed/simple;
	bh=ryrXcVojXUdoy+vqmVuCAexT5zpv+1ng0sqODIFIDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieZj321rLFXlraX0T9joL4HpBucaI4ov5VLEHGIdXYkHNSOw53QRqlN39MYxvUDdjcVdevNqPsHz8CNx0W/Fj1jqNsxXtnlOzQJFX94Yd2ENi4ZR7mxQ5ucVVPKy+Rs1A0KEwDxCWZC9GdMyXvn8mbVsn1kUeJmVfdyC2pZMD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iLQy8yaH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA9r2s019834;
	Wed, 22 Oct 2025 18:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PDJJ9AuF+T/tase8l1IkwlSkkWXulwbb6R9teYH4i
	MQ=; b=iLQy8yaHhMhcCBLBJ4QmnwjbSPIktyLyM9xnKcdwF6IphWDZSdgiQ/nNv
	rKytVr4mq0yeF0udYpwmSSE1siFu2IzxjlrHsx/GU3Uer4Z5Yux1iPNkZ/ko8ikK
	zGyRDWCGo1Gx6zrLlLk3YPLgJZ54QPUtO+oZj9KE+EX0+ZydjVg083FrGGsMxqWa
	EcxLG/ATV2CucMeDNMH9+UgLtbS7vKbcs74hkFKip0rGQ+sKDiwONmMI8y86pASh
	+8uqQHUux6NPTpviXjHYnge2ukdHsuTsNM0y5yXD3iJc6UGDNjE5P0hOOhiEV205
	X7t5FyG8UgRT+dr+wMJWznpi7h5QQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326xcgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIF4JR005619;
	Wed, 22 Oct 2025 18:27:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326xcgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIQEZR002281;
	Wed, 22 Oct 2025 18:27:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejhptq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MIRjNI17105470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:27:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B99F05805F;
	Wed, 22 Oct 2025 18:27:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA0575805D;
	Wed, 22 Oct 2025 18:27:44 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:27:44 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
        razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH net-next v14 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Wed, 22 Oct 2025 11:25:27 -0700
Message-ID: <20251022182721.2567561-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f92225 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=_9dExB9TU08cRdUV:21 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=EmhSL4SpXxSzLOs6qSgA:9 a=zY0JdQc1-4EAyPf5TuXT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7XiMIWxdz1o9
 AKRO5gtXpyWHeFN9jYM5eEyRBE7DB8ev6jHLtXxYcB5v/cYc/rUWiorDuH26cByTYSACpZoi7LP
 BUxOhpP+e1CRBpG2RWA8BgTs6JVfWzw96aMQTM3kB2sszERpzW2+1pgIAcad2dWftFT9RBMiUe6
 fZJfvIRleXyHp9lRzTon+ZefyOAMhdwTqTER2JUMlRVhUXFrZJjLCqJOrcBW2pRm+V2pCXIVZB2
 HVYRifRRdZ06W2DySlEbXiLIaTQl833SW0s3aDTFbgnNg5+DYlIaRVqg708usU/D1APj6pAU3P3
 k81Pws0zmwSf3loE/6WvTb+X3hOhTxbywZHMYIQaSn1jfGLbggrQ+kFST9Tmw/6tw1iFqWjvmCi
 nd2RfrONPU6OOqQsUI+0WDpVltmY8Q==
X-Proofpoint-GUID: dpqt8GeDH3N6WQAmLynEyabgHVNyl_qZ
X-Proofpoint-ORIG-GUID: EVCIOOSGHuhbEiQ3g72vNI_jf9q37Si-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

The current implementation of the arp monitor builds a list of vlan-tags by
following the chain of net_devices above the bond. See bond_verify_device_path().
Unfortunately, with some configurations, this is not possible. One example is
when an ovs switch is configured above the bond.

This change extends the "arp_ip_target" parameter format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.

The new format for arp_ip_target is:
arp_ip_target ipv4-address[vlan-tag\...],...

For example:
arp_ip_target 10.0.0.1[10/20]
arp_ip_target 10.0.0.1[] (used to disable vlan discovery)

Changes since V13
Thanks for the help Paolo:
- Changed first argument of bond_option_arp_ip_target_add() to a const.
- Changed first argument of bond_arp_target_to_string to a const.
- Added compiler time check of size argument to: bond_arp_target_to_string(),
	BUILD_BUG_ON(size != BOND_OPTION_STRING_MAX_SIZE);
- In bond_arp_send_all() I changed the condition for both the allocation and
  the free calls to be the same to improve the clarity of the code.
- Removed extra tab in bond_fill_info().
- Updated update bond_get_size() to reflect the increased payload for the
  arp_ip_target option.
- Corrected indentation and alignment in bond-arp-ip-target.sh.

Changes since V12
Fixed uninitialized variable in bond_option_arp_ip_targets_set() (patch 4)
causing a CI failure.

Changes since V11
No Change.

Changes since V10
Thanks Paolo:
- 1/7 Changed the layout of struct bond_arp_target to reduce size of the struct.
- 3/7 Fixed format 'size-num' -> 'size - num'
- 7/7 Updated selftest (bond-arp-ip-target.sh). Removed sleep 10 in check_failure_count().
      Added call to tc to verify arp probes are reaching the target interface. Then I verify that
      the Link Failure counts are not increasing over "time".  Arp probes are sent every 100ms,
      two missed probes will trigger a Link failure. A one second wait between checking counts
      should be be more than sufficient.  This speeds up the execution of the test.

Thanks Nikolay:
- 4/7 In bond_option_arp_ip_targets_clear() I changed the definition of empty_target to empty_target = {}.
-     bond_validate_tags() now verifies input is a multiple of sizeof(struct bond_vlan_tag).
      Updated VID validity check to use: !tags->vlan_id || tags->vlan_id >= VLAN_VID_MASK) as suggested.
-     In bond_option_arp_ip_targets_set() removed the redundant length check of target.target_ip.
-     Added kfree(target.tags) when bond_option_arp_ip_target_add() results in an error.
-     Removed the caching of struct bond_vlan_tag returned by bond_verify_device_path(), Nikolay
      pointed out that caching tags prevented the detection of VLAN configuration changes. 
      Added a kfree(tags) for tags allocated in bond_verify_device_path().

Jay, Nikolay and I had a discussion regarding locking when adding, deleting or changing vlan tags.
Jay pointed out that user supplied tags that are stashed in the bond configuration and can only be
changed via user space this can be done safely in an RCU manner as netlink always operates with RTNL
held. If user space provided tags and then replumbs things, it'll be on user space to update the tags
in a safe manor.  

I was concerned about changing options on a configured bond,  I found that attempting to change
a bonds configuration (using "ip set") will abort the attempt to make a change if the bond's state is
"UP" or has slaves configured. Therefor the configuration and operational side of a bond is separated.
I agree with Jay that the existing locking scheme is sufficient.

Change since V9
Fix kdoc build error.

Changes since V8:
Moved the #define BOND_MAX_VLAN_TAGS from patch 6 to patch 3.
Thanks Simon for catching the bisection break.

Changes since V7:
These changes should eliminate the CI failures I have been seeing.
1) patch 2, changed type of bond_opt_value.extra_len to size_t.
2) Patch 4, added bond_validate_tags() to validate the array of bond_vlan_tag provided by
 the user.

Changes since V6:
1) I made a number of changes to fix the failure seen in the
kernel CI.  I am still unable to reproduce the this failure, hopefully I
have fixed it.  These change are in patch #4 to functions:
bond_option_arp_ip_targets_clear() and
bond_option_arp_ip_targets_set()

Changes since V5: Only the last 2 patches have changed since V5.
1) Fixed sparse warning in bond_fill_info().
2) Also in bond_fill_info() I resolved data.addr uninitialized when if condition is not met.
Thank you Simon for catching this. Note: The change is different that what I shared earlier.
3) Fixed shellcheck warnings in test script: Blocked source warning, Ignored specific unassigned
references and exported ALL_TESTS to resolve a reference warning.

Changes since V4:
1)Dropped changes to proc and sysfs APIs to bonding.  These APIs 
do not need to be updated to support new functionality.  Netlink
and iproute2 have been updated to do the right thing, but the
other APIs are more or less frozen in the past.

2)Jakub reported a warning triggered in bond_info_seq_show() during
testing.  I was unable to reproduce this warning or identify
it with code inspection.  However, all my changes to bond_info_seq_show()
have been dropped as unnecessary (see above).
Hopefully this will resolve the issue. 

3)Selftest script has been updated based on the results of shellcheck.
Two unresolved references that are not possible to resolve are all
that remain.

4)A patch was added updating bond_info_fill()
to support "ip -d show <bond-device>" command.

The inclusion of a list of vlan tags is optional. The new logic
preserves both forward and backward compatibility with the kernel
and iproute2 versions.

Changes since V3:
1) Moved the parsing of the extended arp_ip_target out of the kernel and into
   userspace (ip command). A separate patch to iproute2 to follow shortly.
2) Split up the patch set to make review easier.

Please see iproute changes in a separate posting.

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (7):
  bonding: Adding struct bond_arp_target
  bonding: Adding extra_len field to struct bond_opt_value.
  bonding: arp_ip_target helpers.
  bonding: Processing extended arp_ip_target from user space.
  bonding: Update to bond_arp_send_all() to use supplied vlan tags
  bonding: Update for extended arp_ip_target format.
  bonding: Selftest and documentation for the arp_ip_target parameter.

 Documentation/networking/bonding.rst          |  11 +
 drivers/net/bonding/bond_main.c               |  48 +++--
 drivers/net/bonding/bond_netlink.c            |  39 +++-
 drivers/net/bonding/bond_options.c            | 146 ++++++++++---
 drivers/net/bonding/bond_procfs.c             |   4 +-
 drivers/net/bonding/bond_sysfs.c              |   4 +-
 include/net/bond_options.h                    |  29 ++-
 include/net/bonding.h                         |  67 +++++-
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond-arp-ip-target.sh | 204 ++++++++++++++++++
 10 files changed, 474 insertions(+), 79 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.50.1


