Return-Path: <linux-kselftest+bounces-2140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90A5816B72
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 11:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E07B2133B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44B15E8E;
	Mon, 18 Dec 2023 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZqIxm4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98515E9F;
	Mon, 18 Dec 2023 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI9qRSK029163;
	Mon, 18 Dec 2023 10:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=c/slSTZMPMwLuaIW4Rh3LHKaewsO81MjqBiewp5e/xQ=;
 b=iZqIxm4vZbqtwu22M4SSy8S/T52DuJGBle1EuI6UJ7pQQIZBWuJ0GhksUZxi9qgTx+Wd
 bdF8cU1DnoCCklYlZyDJ1l6Qi4Kr3oXZGUMuQzqjfYD0URxrzUhj68enoS5McjzepetM
 MswFaE/pqLwcFFdk4dJKPVROatzCsjrtJBgiAgIYI1URWH4M6rHlOrRd+8iIYcN48qIg
 wqruJLQuU2rckFWwdUMhzJLPOurfVib9luJr3JNltxK+XDmpfiBDy+o5x3dGyuUldjbg
 VxLIaCaM9OWgsgFtdwbmIotUbhZS2mklDR6ZflKFs5TsSQYyVfi1Lj0JIkIrkwpZnicb ig== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2ku01ejy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 10:44:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIAKj4X013893;
	Mon, 18 Dec 2023 10:44:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1qqk02br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 10:44:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BIAikhI13173258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 10:44:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8776220063;
	Mon, 18 Dec 2023 10:44:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1087A2006C;
	Mon, 18 Dec 2023 10:44:45 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.6.112])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Dec 2023 10:44:44 +0000 (GMT)
Date: Mon, 18 Dec 2023 11:44:43 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: selftests/livepatch fails on s390
Message-ID: <ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Acs5g1P4J2zG/GLh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D7J0Nf4tkg_CxF2jtaBmGRnXW9yJ5oJc
X-Proofpoint-ORIG-GUID: D7J0Nf4tkg_CxF2jtaBmGRnXW9yJ5oJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_06,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180077


--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The livepatch selftest somehow fails in -next on s390 due to what
appears to me as 'comm' usage issue. E.g the removal of timestamp-
less line "with link type OSD_10GIG." in the below output forces 
'comm' to produce the correct result in check_result() function of
tools/testing/selftests/livepatch/functions.sh script:

[   11.229256] qeth 0.0.bd02: qdio: OSA on SC 2624 using AI:1 QEBSM:0 PRI:1 TDD:1 SIGA: W 
[   11.250189] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.258763] qeth 0.0.bd00: Device is a OSD Express card (level: 0165)
               with link type OSD_10GIG.
[   11.259261] qeth 0.0.bd00: The device represents a Bridge Capable Port
[   11.262376] qeth 0.0.bd00: MAC address b2:96:9c:49:aa:e9 successfully registered
[   11.269654] qeth 0.0.bd00: MAC address 06:c6:b5:7d:ee:63 successfully registered

By contrast, using the 'diff' instead works as a charm. But it was
removed with commit 2f3f651f3756 ("selftests/livepatch: Use "comm"
instead of "diff" for dmesg").

I am attaching the contents of "$expect" and "$result" script
variables and the output of 'dmesg' before and after test run
dmesg-saved.txt and dmesg.txt.

Another 'dmesg' output dmesg-saved1.txt and dmesg1.txt also
shows the same problem, which seems like something to do with
sorting.

The minimal reproducer attached is dmesg-saved1-rep.txt and
dmesg1-rep.txt, that could be described as:

--- dmesg-saved1-rep.txt	2023-12-17 21:08:14.171014218 +0100
+++ dmesg1-rep.txt	2023-12-17 21:06:52.221014218 +0100
@@ -1,3 +1,3 @@
-[   98.820331] livepatch: 'test_klp_state2': starting patching transition
 [  100.031067] livepatch: 'test_klp_state2': completing patching transition
 [  284.224335] livepatch: kernel.ftrace_enabled = 1
+[  284.232921] ===== TEST: basic shadow variable API =====

The culprit is the extra space in [   98.820331] timestamp, that from
the script point of view produces the output with two extra lines:

[  100.031067] livepatch: 'test_klp_state2': completing patching transition
[  284.224335] livepatch: kernel.ftrace_enabled = 1
[  284.232921] ===== TEST: basic shadow variable API =====

If the line with [   98.820331] timestamp removed or changed to e.g
[  100.031066] (aka 1 us less), then the result output is as expected:

[  284.232921] ===== TEST: basic shadow variable API =====

Thanks!

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dmesg-saved.txt"
Content-Transfer-Encoding: 8bit

[   11.189483] systemd-journald[943]: varlink-22: Changing state processed-method → idle-server
[   11.190633] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.190705] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.191385] systemd-journald[943]: varlink-22: Got POLLHUP from socket.
[   11.191389] systemd-journald[943]: varlink-22: Changing state idle-server → pending-disconnect
[   11.191392] systemd-journald[943]: varlink-22: Changing state pending-disconnect → processing-disconnect
[   11.191395] systemd-journald[943]: varlink-22: Changing state processing-disconnect → disconnected
[   11.200993] VFIO - User Level meta-driver version: 0.3
[   11.224375] qeth 0.0.bd00: CHID: 1a0 CHPID: 98
[   11.229256] qeth 0.0.bd02: qdio: OSA on SC 2624 using AI:1 QEBSM:0 PRI:1 TDD:1 SIGA: W 
[   11.250189] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.258763] qeth 0.0.bd00: Device is a OSD Express card (level: 0165)
               with link type OSD_10GIG.
[   11.259261] qeth 0.0.bd00: The device represents a Bridge Capable Port
[   11.262376] qeth 0.0.bd00: MAC address b2:96:9c:49:aa:e9 successfully registered
[   11.269654] qeth 0.0.bd00: MAC address 06:c6:b5:7d:ee:63 successfully registered
[   11.272060] qeth 0.0.bd00 encbd00: renamed from eth0
[   11.310918] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.323102] dasdconf.sh Warning: 0.0.627c is already online, not configuring
[   11.343058] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.347561] zram0: detected capacity change from 0 to 16777216
[   11.359549] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.377984] Adding 8388604k swap on /dev/zram0.  Priority:100 extents:1 across:8388604k SSDsc
[   11.381599] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.390605] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.397956] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.552967] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.569530] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.575683] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.605458] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.611661] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.615960] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.714654] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.716630] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.743224] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.745027] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.746763] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.751180] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.752995] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   11.920342] dasd-eckd 0.0.627f: A channel path to the device has become operational
[   11.920856] dasd-eckd 0.0.627f: A channel path to the device has become operational
[   11.928668] dasd-eckd 0.0.627f: New DASD 3390/0C (CU 3990/04) with 30051 cylinders, 15 heads, 224 sectors
[   11.941252] zfcp 0.0.1900: qdio: ZFCP on SC 61 using AI:1 QEBSM:0 PRI:1 TDD:1 SIGA: W 
[   11.948281] dasd-eckd 0.0.627f: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
[   11.949271]  dasdb:VOL1/  0X627F: dasdb1 dasdb2
[   11.970413] scsi host0: scsi_eh_0: sleeping
[   11.970560] scsi host0: zfcp
[   12.028341] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.032979] zfcp 0.0.1900: FC Endpoint Security of connection to remote port 0x500507630910d435 enabled: Encryption
[   12.035107] scsi 0:0:0:0: scsi scan: INQUIRY pass 1 length 36
[   12.035239] scsi 0:0:0:0: scsi scan: INQUIRY successful with code 0x0
[   12.035246] scsi 0:0:0:0: scsi scan: INQUIRY pass 2 length 164
[   12.035345] scsi 0:0:0:0: scsi scan: INQUIRY successful with code 0x0
[   12.035350] scsi 0:0:0:0: scsi scan: peripheral device type of 31, no device added
[   12.035679] scsi 0:0:0:0: scsi scan: Sending REPORT LUNS to (try 0)
[   12.036992] scsi 0:0:0:0: scsi scan: REPORT LUNS successful (try 0) result 0x0
[   12.036994] scsi 0:0:0:0: scsi scan: REPORT LUN scan
[   12.037241] scsi 0:0:0:1084113024: scsi scan: INQUIRY pass 1 length 36
[   12.037394] scsi 0:0:0:1084113024: scsi scan: INQUIRY successful with code 0x0
[   12.037399] scsi 0:0:0:1084113024: scsi scan: INQUIRY pass 2 length 164
[   12.037496] scsi 0:0:0:1084113024: scsi scan: INQUIRY successful with code 0x0
[   12.037502] scsi 0:0:0:1084113024: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.038919] scsi 0:0:0:1084113024: alua: supports implicit TPGS
[   12.038922] scsi 0:0:0:1084113024: alua: device naa.6005076309ffd435000000000000809e port group 0 rel port 203
[   12.038952] sd 0:0:0:1084113024: sg_alloc: dev=0 
[   12.038982] sd 0:0:0:1084113024: Attached scsi generic sg0 type 0
[   12.039272] scsi 0:0:0:1084178560: scsi scan: INQUIRY pass 1 length 36
[   12.039319] sd 0:0:0:1084113024: Power-on or device reset occurred
[   12.039325] sd 0:0:0:1084113024: [sda] tag#640 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.039328] sd 0:0:0:1084113024: [sda] tag#640 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.039330] sd 0:0:0:1084113024: [sda] tag#640 Sense Key : Unit Attention [current] 
[   12.039333] sd 0:0:0:1084113024: [sda] tag#640 Add. Sense: Power on, reset, or bus device reset occurred
[   12.039384] scsi 0:0:0:1084178560: scsi scan: INQUIRY successful with code 0x0
[   12.039404] scsi 0:0:0:1084178560: scsi scan: INQUIRY pass 2 length 164
[   12.039505] scsi 0:0:0:1084178560: scsi scan: INQUIRY successful with code 0x0
[   12.039510] scsi 0:0:0:1084178560: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.040890] scsi 0:0:0:1084178560: alua: supports implicit TPGS
[   12.040892] scsi 0:0:0:1084178560: alua: device naa.6005076309ffd435000000000000809f port group 0 rel port 203
[   12.040956] sd 0:0:0:1084178560: sg_alloc: dev=1 
[   12.040983] sd 0:0:0:1084178560: Attached scsi generic sg1 type 0
[   12.041244] scsi 0:0:0:1084113025: scsi scan: INQUIRY pass 1 length 36
[   12.041362] sd 0:0:0:1084178560: Power-on or device reset occurred
[   12.041367] sd 0:0:0:1084178560: [sdb] tag#3264 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.041369] sd 0:0:0:1084178560: [sdb] tag#3264 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.041371] sd 0:0:0:1084178560: [sdb] tag#3264 Sense Key : Unit Attention [current] 
[   12.041373] sd 0:0:0:1084178560: [sdb] tag#3264 Add. Sense: Power on, reset, or bus device reset occurred
[   12.041405] scsi 0:0:0:1084113025: scsi scan: INQUIRY successful with code 0x0
[   12.041410] scsi 0:0:0:1084113025: scsi scan: INQUIRY pass 2 length 164
[   12.041580] scsi 0:0:0:1084113025: scsi scan: INQUIRY successful with code 0x0
[   12.041585] scsi 0:0:0:1084113025: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.042960] scsi 0:0:0:1084113025: alua: supports implicit TPGS
[   12.042962] scsi 0:0:0:1084113025: alua: device naa.6005076309ffd435000000000000819e port group 0 rel port 203
[   12.043005] sd 0:0:0:1084113025: sg_alloc: dev=2 
[   12.043063] sd 0:0:0:1084113025: Attached scsi generic sg2 type 0
[   12.043298] scsi 0:0:0:1084178561: scsi scan: INQUIRY pass 1 length 36
[   12.043309] sd 0:0:0:1084113025: Power-on or device reset occurred
[   12.043312] sd 0:0:0:1084113025: [sdc] tag#641 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.043314] sd 0:0:0:1084113025: [sdc] tag#641 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.043316] sd 0:0:0:1084113025: [sdc] tag#641 Sense Key : Unit Attention [current] 
[   12.043317] sd 0:0:0:1084113025: [sdc] tag#641 Add. Sense: Power on, reset, or bus device reset occurred
[   12.043423] scsi 0:0:0:1084178561: scsi scan: INQUIRY successful with code 0x0
[   12.043428] scsi 0:0:0:1084178561: scsi scan: INQUIRY pass 2 length 164
[   12.043531] scsi 0:0:0:1084178561: scsi scan: INQUIRY successful with code 0x0
[   12.043536] scsi 0:0:0:1084178561: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.044875] scsi 0:0:0:1084178561: alua: supports implicit TPGS
[   12.044877] scsi 0:0:0:1084178561: alua: device naa.6005076309ffd435000000000000819f port group 0 rel port 203
[   12.044927] scsi 0:0:0:1084178561: sg_alloc: dev=3 
[   12.044950] scsi 0:0:0:1084178561: Attached scsi generic sg3 type 0
[   12.045107] sd 0:0:0:1084113024: scsi scan: device exists on 0:0:0:1084113024
[   12.045243] sd 0:0:0:1084178561: Power-on or device reset occurred
[   12.045244] sd 0:0:0:1084178560: scsi scan: device exists on 0:0:0:1084178560
[   12.045247] sd 0:0:0:1084178561: [sdd] tag#3265 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.045250] sd 0:0:0:1084178561: [sdd] tag#3265 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.045252] sd 0:0:0:1084178561: [sdd] tag#3265 Sense Key : Unit Attention [current] 
[   12.045254] sd 0:0:0:1084178561: [sdd] tag#3265 Add. Sense: Power on, reset, or bus device reset occurred
[   12.045305] sd 0:0:0:1084113025: scsi scan: device exists on 0:0:0:1084113025
[   12.045373] sd 0:0:0:1084178561: scsi scan: device exists on 0:0:0:1084178561
[   12.050288] sd 0:0:0:1084113024: [sda] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.050294] sd 0:0:0:1084113024: alua: transition timeout set to 60 seconds
[   12.050309] sd 0:0:0:1084113024: alua: port group 00 state A preferred supports tolusnA
[   12.050393] sd 0:0:0:1084113024: [sda] Write Protect is off
[   12.050395] sd 0:0:0:1084113024: [sda] Mode Sense: ed 00 00 08
[   12.050571] sd 0:0:0:1084113024: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.050678] sd 0:0:0:1084113024: [sda] tag#648 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.050680] sd 0:0:0:1084113024: [sda] tag#648 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.050682] sd 0:0:0:1084113024: [sda] tag#648 Sense Key : Illegal Request [current] 
[   12.050684] sd 0:0:0:1084113024: [sda] tag#648 Add. Sense: Invalid field in cdb
[   12.052828] sd 0:0:0:1084113024: [sda] tag#651 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.052830] sd 0:0:0:1084113024: [sda] tag#651 CDB: Inquiry 12 01 b9 00 04 00
[   12.052832] sd 0:0:0:1084113024: [sda] tag#651 Sense Key : Illegal Request [current] 
[   12.052833] sd 0:0:0:1084113024: [sda] tag#651 Add. Sense: Invalid field in cdb
[   12.054252]  sda: sda1
[   12.059079] sd 0:0:0:1084113024: [sda] Attached SCSI disk
[   12.060240] sd 0:0:0:1084113025: [sdc] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.060242] sd 0:0:0:1084178561: [sdd] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.060287] sd 0:0:0:1084178561: alua: transition timeout set to 60 seconds
[   12.060290] sd 0:0:0:1084178561: alua: port group 00 state A preferred supports tolusnA
[   12.060294] sd 0:0:0:1084113025: alua: transition timeout set to 60 seconds
[   12.060295] sd 0:0:0:1084178560: [sdb] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.060296] sd 0:0:0:1084113025: alua: port group 00 state A preferred supports tolusnA
[   12.060330] sd 0:0:0:1084178560: alua: transition timeout set to 60 seconds
[   12.060334] sd 0:0:0:1084113025: [sdc] Write Protect is off
[   12.060334] sd 0:0:0:1084178560: alua: port group 00 state A preferred supports tolusnA
[   12.060336] sd 0:0:0:1084178561: [sdd] Write Protect is off
[   12.060336] sd 0:0:0:1084113025: [sdc] Mode Sense: ed 00 00 08
[   12.060339] sd 0:0:0:1084178561: [sdd] Mode Sense: ed 00 00 08
[   12.060397] sd 0:0:0:1084178560: [sdb] Write Protect is off
[   12.060398] sd 0:0:0:1084178560: [sdb] Mode Sense: ed 00 00 08
[   12.060544] sd 0:0:0:1084113025: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.060544] sd 0:0:0:1084178561: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.060588] sd 0:0:0:1084178560: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.060692] sd 0:0:0:1084178560: [sdb] tag#1226 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.060695] sd 0:0:0:1084178560: [sdb] tag#1226 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.060697] sd 0:0:0:1084178560: [sdb] tag#1226 Sense Key : Illegal Request [current] 
[   12.060699] sd 0:0:0:1084178560: [sdb] tag#1226 Add. Sense: Invalid field in cdb
[   12.060784] sd 0:0:0:1084178561: [sdd] tag#1227 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.060786] sd 0:0:0:1084178561: [sdd] tag#1227 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.060788] sd 0:0:0:1084178561: [sdd] tag#1227 Sense Key : Illegal Request [current] 
[   12.060790] sd 0:0:0:1084178561: [sdd] tag#1227 Add. Sense: Invalid field in cdb
[   12.060797] sd 0:0:0:1084113025: [sdc] tag#672 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.060816] sd 0:0:0:1084178561: [sdd] Disabling DIF Type 1 protection
[   12.060817] sd 0:0:0:1084113025: [sdc] tag#672 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.060818] sd 0:0:0:1084178561: [sdd] Enabling DIF Type 0 protection
[   12.060820] sd 0:0:0:1084113025: [sdc] tag#672 Sense Key : Illegal Request [current] 
[   12.060823] sd 0:0:0:1084113025: [sdc] tag#672 Add. Sense: Invalid field in cdb
[   12.060828] sd 0:0:0:1084113025: [sdc] Disabling DIF Type 1 protection
[   12.060830] sd 0:0:0:1084113025: [sdc] Enabling DIF Type 0 protection
[   12.063360] sd 0:0:0:1084178561: [sdd] tag#3274 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.063363] sd 0:0:0:1084178561: [sdd] tag#3274 CDB: Inquiry 12 01 b9 00 04 00
[   12.063364] sd 0:0:0:1084178561: [sdd] tag#3274 Sense Key : Illegal Request [current] 
[   12.063367] sd 0:0:0:1084178561: [sdd] tag#3274 Add. Sense: Invalid field in cdb
[   12.063825] sd 0:0:0:1084113025: [sdc] tag#675 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.063827] sd 0:0:0:1084113025: [sdc] tag#675 CDB: Inquiry 12 01 b9 00 04 00
[   12.063829] sd 0:0:0:1084113025: [sdc] tag#675 Sense Key : Illegal Request [current] 
[   12.063830] sd 0:0:0:1084113025: [sdc] tag#675 Add. Sense: Invalid field in cdb
[   12.063837] sd 0:0:0:1084178560: [sdb] tag#1230 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.063839] sd 0:0:0:1084178560: [sdb] tag#1230 CDB: Inquiry 12 01 b9 00 04 00
[   12.063841] sd 0:0:0:1084178560: [sdb] tag#1230 Sense Key : Illegal Request [current] 
[   12.063843] sd 0:0:0:1084178560: [sdb] tag#1230 Add. Sense: Invalid field in cdb
[   12.063920] sd 0:0:0:1084178561: [sdd] Attached SCSI disk
[   12.064305] sd 0:0:0:1084178560: [sdb] Attached SCSI disk
[   12.064457] sd 0:0:0:1084113025: [sdc] Attached SCSI disk
[   12.118155] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.173553] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.213521] device-mapper: multipath service-time: version 0.3.0 loaded
[   12.320946] zfcp 0.0.1940: qdio: ZFCP on SC 62 using AI:1 QEBSM:0 PRI:1 TDD:1 SIGA: W 
[   12.350368] scsi host1: scsi_eh_1: sleeping
[   12.350411] scsi host1: zfcp
[   12.415631] zfcp 0.0.1940: FC Endpoint Security of connection to remote port 0x500507630914d435 enabled: Encryption
[   12.417541] scsi 1:0:0:0: scsi scan: INQUIRY pass 1 length 36
[   12.417634] scsi 1:0:0:0: scsi scan: INQUIRY successful with code 0x0
[   12.417658] scsi 1:0:0:0: scsi scan: INQUIRY pass 2 length 164
[   12.417749] scsi 1:0:0:0: scsi scan: INQUIRY successful with code 0x0
[   12.417755] scsi 1:0:0:0: scsi scan: peripheral device type of 31, no device added
[   12.418087] scsi 1:0:0:0: scsi scan: Sending REPORT LUNS to (try 0)
[   12.418541] scsi 1:0:0:0: scsi scan: REPORT LUNS successful (try 0) result 0x0
[   12.418543] scsi 1:0:0:0: scsi scan: REPORT LUN scan
[   12.418789] scsi 1:0:0:1084113024: scsi scan: INQUIRY pass 1 length 36
[   12.418903] scsi 1:0:0:1084113024: scsi scan: INQUIRY successful with code 0x0
[   12.418908] scsi 1:0:0:1084113024: scsi scan: INQUIRY pass 2 length 164
[   12.419005] scsi 1:0:0:1084113024: scsi scan: INQUIRY successful with code 0x0
[   12.419010] scsi 1:0:0:1084113024: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.420462] scsi 1:0:0:1084113024: alua: supports implicit TPGS
[   12.420466] scsi 1:0:0:1084113024: alua: device naa.6005076309ffd435000000000000809e port group 0 rel port 243
[   12.420514] sd 1:0:0:1084113024: sg_alloc: dev=4 
[   12.420566] sd 1:0:0:1084113024: Attached scsi generic sg4 type 0
[   12.420859] scsi 1:0:0:1084178560: scsi scan: INQUIRY pass 1 length 36
[   12.420863] sd 1:0:0:1084113024: Power-on or device reset occurred
[   12.420867] sd 1:0:0:1084113024: [sde] tag#1664 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.420870] sd 1:0:0:1084113024: [sde] tag#1664 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.420872] sd 1:0:0:1084113024: [sde] tag#1664 Sense Key : Unit Attention [current] 
[   12.420874] sd 1:0:0:1084113024: [sde] tag#1664 Add. Sense: Power on, reset, or bus device reset occurred
[   12.420971] scsi 1:0:0:1084178560: scsi scan: INQUIRY successful with code 0x0
[   12.420976] scsi 1:0:0:1084178560: scsi scan: INQUIRY pass 2 length 164
[   12.421074] scsi 1:0:0:1084178560: scsi scan: INQUIRY successful with code 0x0
[   12.421079] scsi 1:0:0:1084178560: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.422435] scsi 1:0:0:1084178560: alua: supports implicit TPGS
[   12.422438] scsi 1:0:0:1084178560: alua: device naa.6005076309ffd435000000000000809f port group 0 rel port 243
[   12.422481] sd 1:0:0:1084178560: sg_alloc: dev=5 
[   12.422513] sd 1:0:0:1084178560: Attached scsi generic sg5 type 0
[   12.422818] scsi 1:0:0:1084113025: scsi scan: INQUIRY pass 1 length 36
[   12.422918] scsi 1:0:0:1084113025: scsi scan: INQUIRY successful with code 0x0
[   12.422923] scsi 1:0:0:1084113025: scsi scan: INQUIRY pass 2 length 164
[   12.423017] scsi 1:0:0:1084113025: scsi scan: INQUIRY successful with code 0x0
[   12.423022] scsi 1:0:0:1084113025: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.423169] sd 1:0:0:1084178560: Power-on or device reset occurred
[   12.423173] sd 1:0:0:1084178560: [sdf] tag#896 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.423175] sd 1:0:0:1084178560: [sdf] tag#896 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.423176] sd 1:0:0:1084178560: [sdf] tag#896 Sense Key : Unit Attention [current] 
[   12.423178] sd 1:0:0:1084178560: [sdf] tag#896 Add. Sense: Power on, reset, or bus device reset occurred
[   12.424628] scsi 1:0:0:1084113025: alua: supports implicit TPGS
[   12.424630] scsi 1:0:0:1084113025: alua: device naa.6005076309ffd435000000000000819e port group 0 rel port 243
[   12.424675] sd 1:0:0:1084113025: sg_alloc: dev=6 
[   12.424746] sd 1:0:0:1084113025: Attached scsi generic sg6 type 0
[   12.425035] scsi 1:0:0:1084178561: scsi scan: INQUIRY pass 1 length 36
[   12.425136] scsi 1:0:0:1084178561: scsi scan: INQUIRY successful with code 0x0
[   12.425141] scsi 1:0:0:1084178561: scsi scan: INQUIRY pass 2 length 164
[   12.425154] sd 1:0:0:1084113025: Power-on or device reset occurred
[   12.425157] sd 1:0:0:1084113025: [sdg] tag#1665 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.425159] sd 1:0:0:1084113025: [sdg] tag#1665 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.425161] sd 1:0:0:1084113025: [sdg] tag#1665 Sense Key : Unit Attention [current] 
[   12.425163] sd 1:0:0:1084113025: [sdg] tag#1665 Add. Sense: Power on, reset, or bus device reset occurred
[   12.425233] scsi 1:0:0:1084178561: scsi scan: INQUIRY successful with code 0x0
[   12.425238] scsi 1:0:0:1084178561: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.426688] scsi 1:0:0:1084178561: alua: supports implicit TPGS
[   12.426691] scsi 1:0:0:1084178561: alua: device naa.6005076309ffd435000000000000819f port group 0 rel port 243
[   12.426934] sd 1:0:0:1084178561: sg_alloc: dev=7 
[   12.427059] sd 1:0:0:1084178561: Attached scsi generic sg7 type 0
[   12.427341] sd 1:0:0:1084113024: scsi scan: device exists on 1:0:0:1084113024
[   12.427411] sd 1:0:0:1084178561: Power-on or device reset occurred
[   12.427414] sd 1:0:0:1084178561: [sdh] tag#897 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.427417] sd 1:0:0:1084178561: [sdh] tag#897 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.427419] sd 1:0:0:1084178561: [sdh] tag#897 Sense Key : Unit Attention [current] 
[   12.427422] sd 1:0:0:1084178561: [sdh] tag#897 Add. Sense: Power on, reset, or bus device reset occurred
[   12.427766] sd 1:0:0:1084178560: scsi scan: device exists on 1:0:0:1084178560
[   12.428386] sd 1:0:0:1084113025: scsi scan: device exists on 1:0:0:1084113025
[   12.428806] sd 1:0:0:1084178561: scsi scan: device exists on 1:0:0:1084178561
[   12.440305] sd 1:0:0:1084113025: [sdg] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440309] sd 1:0:0:1084113024: [sde] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440328] sd 1:0:0:1084178561: [sdh] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440365] sd 1:0:0:1084178560: [sdf] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440405] sd 1:0:0:1084113025: [sdg] Write Protect is off
[   12.440406] sd 1:0:0:1084113025: [sdg] Mode Sense: ed 00 00 08
[   12.440408] sd 1:0:0:1084113024: [sde] Write Protect is off
[   12.440410] sd 1:0:0:1084113024: [sde] Mode Sense: ed 00 00 08
[   12.440426] sd 1:0:0:1084178561: [sdh] Write Protect is off
[   12.440428] sd 1:0:0:1084178561: [sdh] Mode Sense: ed 00 00 08
[   12.440451] sd 1:0:0:1084178560: [sdf] Write Protect is off
[   12.440453] sd 1:0:0:1084178560: [sdf] Mode Sense: ed 00 00 08
[   12.440613] sd 1:0:0:1084113025: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440615] sd 1:0:0:1084113024: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440625] sd 1:0:0:1084178561: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440627] sd 1:0:0:1084178560: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440709] sd 1:0:0:1084113024: [sde] tag#2055 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440712] sd 1:0:0:1084113024: [sde] tag#2055 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440714] sd 1:0:0:1084113024: [sde] tag#2055 Sense Key : Illegal Request [current] 
[   12.440716] sd 1:0:0:1084113024: [sde] tag#2055 Add. Sense: Invalid field in cdb
[   12.440722] sd 1:0:0:1084178560: [sdf] tag#906 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440724] sd 1:0:0:1084178560: [sdf] tag#906 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440727] sd 1:0:0:1084178560: [sdf] tag#906 Sense Key : Illegal Request [current] 
[   12.440729] sd 1:0:0:1084178560: [sdf] tag#906 Add. Sense: Invalid field in cdb
[   12.440826] sd 1:0:0:1084113025: [sdg] tag#1677 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440846] sd 1:0:0:1084113025: [sdg] tag#1677 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440849] sd 1:0:0:1084113025: [sdg] tag#1677 Sense Key : Illegal Request [current] 
[   12.440851] sd 1:0:0:1084113025: [sdg] tag#1677 Add. Sense: Invalid field in cdb
[   12.440855] sd 1:0:0:1084113025: [sdg] Disabling DIF Type 1 protection
[   12.440857] sd 1:0:0:1084113025: [sdg] Enabling DIF Type 0 protection
[   12.440861] sd 1:0:0:1084178561: [sdh] tag#325 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440874] sd 1:0:0:1084178561: [sdh] tag#325 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440881] sd 1:0:0:1084178561: [sdh] tag#325 Sense Key : Illegal Request [current] 
[   12.440882] sd 1:0:0:1084178561: [sdh] tag#325 Add. Sense: Invalid field in cdb
[   12.440886] sd 1:0:0:1084178561: [sdh] Disabling DIF Type 1 protection
[   12.440888] sd 1:0:0:1084178561: [sdh] Enabling DIF Type 0 protection
[   12.443759] sd 1:0:0:1084113024: [sde] tag#1679 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443780] sd 1:0:0:1084113024: [sde] tag#1679 CDB: Inquiry 12 01 b9 00 04 00
[   12.443782] sd 1:0:0:1084113024: [sde] tag#1679 Sense Key : Illegal Request [current] 
[   12.443785] sd 1:0:0:1084113024: [sde] tag#1679 Add. Sense: Invalid field in cdb
[   12.443797] sd 1:0:0:1084178560: [sdf] tag#327 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443800] sd 1:0:0:1084178560: [sdf] tag#327 CDB: Inquiry 12 01 b9 00 04 00
[   12.443802] sd 1:0:0:1084178560: [sdf] tag#327 Sense Key : Illegal Request [current] 
[   12.443805] sd 1:0:0:1084178560: [sdf] tag#327 Add. Sense: Invalid field in cdb
[   12.443902] sd 1:0:0:1084113025: [sdg] tag#1682 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443905] sd 1:0:0:1084113025: [sdg] tag#1682 CDB: Inquiry 12 01 b9 00 04 00
[   12.443908] sd 1:0:0:1084113025: [sdg] tag#1682 Sense Key : Illegal Request [current] 
[   12.443910] sd 1:0:0:1084113025: [sdg] tag#1682 Add. Sense: Invalid field in cdb
[   12.443912] sd 1:0:0:1084178561: [sdh] tag#2057 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443917] sd 1:0:0:1084178561: [sdh] tag#2057 CDB: Inquiry 12 01 b9 00 04 00
[   12.443919] sd 1:0:0:1084178561: [sdh] tag#2057 Sense Key : Illegal Request [current] 
[   12.443921] sd 1:0:0:1084178561: [sdh] tag#2057 Add. Sense: Invalid field in cdb
[   12.444277] sd 1:0:0:1084178560: [sdf] Attached SCSI disk
[   12.444413] sd 1:0:0:1084113025: [sdg] Attached SCSI disk
[   12.444437] sd 1:0:0:1084178561: [sdh] Attached SCSI disk
[   12.445055]  sde: sde1
[   12.445135] sd 1:0:0:1084113024: [sde] Attached SCSI disk
[   12.455157] mlx5_core 0001:00:00.0 ens8192f0np0: Link up
[   12.754503] mlx5_core 0000:00:00.0 ens8320f0np0: Link up
[   12.870161] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.871810] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.873288] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.879490] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.881609] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.883524] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   13.129973] systemd-journald[943]: Compressed data object 621 -> 266 using ZSTD
[   13.130596] systemd-journald[943]: Compressed data object 621 -> 274 using ZSTD
[   14.130283] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   52.526889] crw_info : CRW reports slct=0, oflw=0, chn=0, rsc=B, anc=0, erc=0, rsid=0
[   64.832872] systemd-journald[943]: Compressed data object 533 -> 400 using ZSTD
[   64.919285] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   64.928008] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   65.045916] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   65.046557] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   65.206974] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   84.040569] livepatch: kernel.ftrace_enabled = 1
[   84.047983] ===== TEST: basic function patching =====
[   84.052146] % modprobe test_klp_livepatch
[   84.054139] test_klp_livepatch: tainting kernel with TAINT_LIVEPATCH
[   84.054277] livepatch: enabling patch 'test_klp_livepatch'
[   84.054279] livepatch: 'test_klp_livepatch': initializing patching transition
[   84.055514] livepatch: 'test_klp_livepatch': starting patching transition
[   84.867407] livepatch: 'test_klp_livepatch': completing patching transition
[   84.867542] livepatch: 'test_klp_livepatch': patching complete
[   84.872840] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[   84.872891] livepatch: 'test_klp_livepatch': initializing unpatching transition
[   84.872925] livepatch: 'test_klp_livepatch': starting unpatching transition
[   85.987407] livepatch: 'test_klp_livepatch': completing unpatching transition
[   85.989034] livepatch: 'test_klp_livepatch': unpatching complete
[   86.084797] % rmmod test_klp_livepatch
[   86.153886] ===== TEST: multiple livepatches =====
[   86.157188] % modprobe test_klp_livepatch
[   86.158657] livepatch: enabling patch 'test_klp_livepatch'
[   86.158659] livepatch: 'test_klp_livepatch': initializing patching transition
[   86.159793] livepatch: 'test_klp_livepatch': starting patching transition
[   87.027437] livepatch: 'test_klp_livepatch': completing patching transition
[   87.027546] livepatch: 'test_klp_livepatch': patching complete
[   87.078385] test_klp_livepatch: this has been live patched
[   87.083290] % modprobe test_klp_atomic_replace replace=0
[   87.085500] livepatch: enabling patch 'test_klp_atomic_replace'
[   87.085502] livepatch: 'test_klp_atomic_replace': initializing patching transition
[   87.086685] livepatch: 'test_klp_atomic_replace': starting patching transition
[   87.907412] livepatch: 'test_klp_atomic_replace': completing patching transition
[   87.907555] livepatch: 'test_klp_atomic_replace': patching complete
[   88.004547] test_klp_livepatch: this has been live patched
[   88.005509] test_klp_atomic_replace: this has been live patched
[   88.005634] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[   88.005721] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[   88.005740] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[   88.947422] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[   88.948800] livepatch: 'test_klp_atomic_replace': unpatching complete
[   89.016537] % rmmod test_klp_atomic_replace
[   89.097952] test_klp_livepatch: this has been live patched
[   89.099036] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[   89.099056] livepatch: 'test_klp_livepatch': initializing unpatching transition
[   89.099079] livepatch: 'test_klp_livepatch': starting unpatching transition
[   89.907443] livepatch: 'test_klp_livepatch': completing unpatching transition
[   89.908927] livepatch: 'test_klp_livepatch': unpatching complete
[   90.008993] % rmmod test_klp_livepatch
[   90.075281] ===== TEST: atomic replace livepatch =====
[   90.078563] % modprobe test_klp_livepatch
[   90.080025] livepatch: enabling patch 'test_klp_livepatch'
[   90.080027] livepatch: 'test_klp_livepatch': initializing patching transition
[   90.081063] livepatch: 'test_klp_livepatch': starting patching transition
[   91.667362] livepatch: 'test_klp_livepatch': completing patching transition
[   91.667466] livepatch: 'test_klp_livepatch': patching complete
[   91.711116] test_klp_livepatch: this has been live patched
[   91.715609] % modprobe test_klp_atomic_replace replace=1
[   91.717349] livepatch: enabling patch 'test_klp_atomic_replace'
[   91.717350] livepatch: 'test_klp_atomic_replace': initializing patching transition
[   91.718440] livepatch: 'test_klp_atomic_replace': starting patching transition
[   93.027449] livepatch: 'test_klp_atomic_replace': completing patching transition
[   93.028821] livepatch: 'test_klp_atomic_replace': patching complete
[   93.044211] test_klp_atomic_replace: this has been live patched
[   93.045414] % rmmod test_klp_livepatch
[   93.138826] test_klp_atomic_replace: this has been live patched
[   93.138945] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[   93.139013] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[   93.139039] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[   93.987388] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[   93.988892] livepatch: 'test_klp_atomic_replace': unpatching complete
[   94.048696] % rmmod test_klp_atomic_replace
[   94.131346] livepatch: kernel.ftrace_enabled = 1
[   94.138074] ===== TEST: target module before livepatch =====
[   94.141712] % modprobe test_klp_callbacks_mod
[   94.143390] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[   94.147450] % modprobe test_klp_callbacks_demo
[   94.149518] livepatch: enabling patch 'test_klp_callbacks_demo'
[   94.149520] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[   94.149584] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[   94.149585] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   94.149586] livepatch: 'test_klp_callbacks_demo': starting patching transition
[   95.827310] livepatch: 'test_klp_callbacks_demo': completing patching transition
[   95.827414] test_klp_callbacks_demo: post_patch_callback: vmlinux
[   95.827416] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   95.827417] livepatch: 'test_klp_callbacks_demo': patching complete
[   95.880751] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[   95.880770] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[   95.880792] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[   95.880793] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   95.880795] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[   96.947362] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[   96.947467] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[   96.947468] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   96.947470] livepatch: 'test_klp_callbacks_demo': unpatching complete
[   96.991491] % rmmod test_klp_callbacks_demo
[   97.047939] % rmmod test_klp_callbacks_mod
[   97.049129] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[   97.123448] ===== TEST: module_coming notifier =====
[   97.126706] % modprobe test_klp_callbacks_demo
[   97.128201] livepatch: enabling patch 'test_klp_callbacks_demo'
[   97.128202] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[   97.128221] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[   97.128222] livepatch: 'test_klp_callbacks_demo': starting patching transition
[   97.907366] livepatch: 'test_klp_callbacks_demo': completing patching transition
[   97.907523] test_klp_callbacks_demo: post_patch_callback: vmlinux
[   97.907524] livepatch: 'test_klp_callbacks_demo': patching complete
[   97.947504] % modprobe test_klp_callbacks_mod
[   97.948836] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[   97.948839] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[   97.948841] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[   97.948883] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[   97.949244] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[   97.949263] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[   97.949283] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[   97.949284] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   97.949285] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[   99.117355] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[   99.117458] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[   99.117460] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   99.117461] livepatch: 'test_klp_callbacks_demo': unpatching complete
[   99.160962] % rmmod test_klp_callbacks_demo
[   99.207962] % rmmod test_klp_callbacks_mod
[   99.209122] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[   99.283107] ===== TEST: module_going notifier =====
[   99.286635] % modprobe test_klp_callbacks_mod
[   99.288047] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[   99.291742] % modprobe test_klp_callbacks_demo
[   99.293440] livepatch: enabling patch 'test_klp_callbacks_demo'
[   99.293441] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[   99.293462] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[   99.293463] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   99.293465] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  101.027350] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  101.027455] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  101.027456] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  101.027458] livepatch: 'test_klp_callbacks_demo': patching complete
[  101.126745] % rmmod test_klp_callbacks_mod
[  101.127848] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  101.127863] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  101.127865] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  101.127866] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  101.187049] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  101.187066] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  101.187085] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  101.187086] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  102.067340] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  102.067461] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  102.067463] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  102.096546] % rmmod test_klp_callbacks_demo
[  102.183243] ===== TEST: module_coming and module_going notifiers =====
[  102.186391] % modprobe test_klp_callbacks_demo
[  102.187856] livepatch: enabling patch 'test_klp_callbacks_demo'
[  102.187858] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  102.187879] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  102.187881] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  103.827367] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  103.827510] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  103.827511] livepatch: 'test_klp_callbacks_demo': patching complete
[  103.920248] % modprobe test_klp_callbacks_mod
[  103.921535] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  103.921537] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  103.921539] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  103.921581] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  103.922691] % rmmod test_klp_callbacks_mod
[  103.923756] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  103.923786] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  103.923788] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  103.923789] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  103.987019] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  103.987036] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  103.987057] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  103.987058] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  105.027318] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  105.027425] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  105.027426] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  105.096960] % rmmod test_klp_callbacks_demo
[  105.193366] ===== TEST: target module not present =====
[  105.196426] % modprobe test_klp_callbacks_demo
[  105.197920] livepatch: enabling patch 'test_klp_callbacks_demo'
[  105.197923] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  105.197944] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  105.197945] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  106.957298] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  106.957421] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  106.957422] livepatch: 'test_klp_callbacks_demo': patching complete
[  107.027668] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  107.027687] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  107.027708] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  107.027709] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  108.067334] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  108.067440] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  108.067441] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  108.137719] % rmmod test_klp_callbacks_demo
[  108.213123] ===== TEST: pre-patch callback -ENODEV =====
[  108.216268] % modprobe test_klp_callbacks_mod
[  108.217645] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  108.218019] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  108.219501] livepatch: enabling patch 'test_klp_callbacks_demo'
[  108.219503] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  108.219523] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  108.219524] livepatch: pre-patch callback failed for object 'vmlinux'
[  108.219524] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  108.219526] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  108.219527] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  108.219633] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  108.366951] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  108.367826] % rmmod test_klp_callbacks_mod
[  108.368966] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  108.463160] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  108.466160] % modprobe test_klp_callbacks_demo
[  108.467614] livepatch: enabling patch 'test_klp_callbacks_demo'
[  108.467616] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  108.467638] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  108.467639] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  109.667362] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  109.667472] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  109.667473] livepatch: 'test_klp_callbacks_demo': patching complete
[  109.689019] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  109.689979] % modprobe test_klp_callbacks_mod
[  109.691291] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  109.691294] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  109.691296] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  109.691297] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  109.837006] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  109.837051] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  109.837066] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  109.837088] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  109.837089] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  111.027394] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  111.027554] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  111.027555] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  111.048716] % rmmod test_klp_callbacks_demo
[  111.124777] ===== TEST: multiple target modules =====
[  111.128696] % modprobe test_klp_callbacks_busy block_transition=N
[  111.130780] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  111.130784] test_klp_callbacks_busy: busymod_work_func enter
[  111.130786] test_klp_callbacks_busy: busymod_work_func exit
[  111.134478] % modprobe test_klp_callbacks_demo
[  111.135984] livepatch: enabling patch 'test_klp_callbacks_demo'
[  111.135986] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  111.136005] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  111.136006] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  111.137437] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  111.987405] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  111.987513] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  111.987515] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  111.987516] livepatch: 'test_klp_callbacks_demo': patching complete
[  112.058064] % modprobe test_klp_callbacks_mod
[  112.059514] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  112.059516] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  112.059518] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  112.059560] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  112.060788] % rmmod test_klp_callbacks_mod
[  112.061910] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  112.061925] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  112.061927] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  112.061928] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  112.137104] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  112.137122] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  112.137143] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  112.137144] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  112.137146] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  113.027375] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  113.029229] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  113.029230] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  113.029232] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  113.046037] % rmmod test_klp_callbacks_demo
[  113.117945] % rmmod test_klp_callbacks_busy
[  113.119077] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  113.184611] ===== TEST: busy target module =====
[  113.187764] % modprobe test_klp_callbacks_busy block_transition=Y
[  113.189352] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  113.189356] test_klp_callbacks_busy: busymod_work_func enter
[  113.192845] % modprobe test_klp_callbacks_demo
[  113.194361] livepatch: enabling patch 'test_klp_callbacks_demo'
[  113.194363] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  113.194384] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  113.194385] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  113.195818] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  113.201297] % modprobe test_klp_callbacks_mod
[  113.202625] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  113.202627] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  113.202719] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  113.203890] % rmmod test_klp_callbacks_mod
[  113.204951] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  113.204963] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  113.204964] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  113.267080] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  113.267098] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  113.267246] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  115.907346] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  115.909130] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  115.909132] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  115.909133] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  115.989675] % rmmod test_klp_callbacks_demo
[  116.047878] % rmmod test_klp_callbacks_busy
[  116.066667] test_klp_callbacks_busy: busymod_work_func exit
[  116.066674] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  116.194426] ===== TEST: multiple livepatches =====
[  116.197597] % modprobe test_klp_callbacks_demo
[  116.199116] livepatch: enabling patch 'test_klp_callbacks_demo'
[  116.199118] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  116.199139] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  116.199140] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  117.667375] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  117.667525] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  117.667527] livepatch: 'test_klp_callbacks_demo': patching complete
[  117.729276] % modprobe test_klp_callbacks_demo2
[  117.731386] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  117.731388] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  117.731409] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  117.731410] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  118.707443] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  118.707552] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  118.707553] livepatch: 'test_klp_callbacks_demo2': patching complete
[  118.749944] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  118.749964] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  118.749986] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  118.749987] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  119.907371] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  119.907541] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  119.907543] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  119.960612] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  119.960630] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  119.960649] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  119.960650] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  120.867332] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  120.867435] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  120.867436] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  120.869780] % rmmod test_klp_callbacks_demo2
[  120.917849] % rmmod test_klp_callbacks_demo
[  120.984589] ===== TEST: atomic replace =====
[  120.987657] % modprobe test_klp_callbacks_demo
[  120.989209] livepatch: enabling patch 'test_klp_callbacks_demo'
[  120.989211] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  120.989232] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  120.989233] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  121.907296] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  121.907399] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  121.907401] livepatch: 'test_klp_callbacks_demo': patching complete
[  122.010261] % modprobe test_klp_callbacks_demo2 replace=1
[  122.011745] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  122.011747] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  122.011767] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  122.011768] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  122.947337] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  122.947446] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  122.947448] livepatch: 'test_klp_callbacks_demo2': patching complete
[  123.030617] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  123.030637] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  123.030658] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  123.030659] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  123.907269] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  123.907424] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  123.907426] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  123.939784] % rmmod test_klp_callbacks_demo2
[  123.987825] % rmmod test_klp_callbacks_demo
[  124.090148] livepatch: kernel.ftrace_enabled = 1
[  124.097727] ===== TEST: basic shadow variable API =====
[  124.101462] % modprobe test_klp_shadow_vars
[  124.103146] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  124.103148] test_klp_shadow_vars:   got expected NULL result
[  124.103150] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  124.103151] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  124.103155] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  124.103156] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  124.103158] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  124.103160] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  124.103162] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  124.103163] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  124.103165] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  124.103167] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  124.103169] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  124.103170] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  124.103173] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  124.103174] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  124.103175] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  124.103176] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  124.103177] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  124.103179] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  124.103180] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  124.103181] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  124.103182] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  124.103184] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  124.103185] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  124.103186] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  124.103187] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  124.103189] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  124.103191] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  124.103193] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  124.103194] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  124.103196] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  124.103197] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  124.103199] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  124.103200] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  124.103201] test_klp_shadow_vars:   got expected NULL result
[  124.103202] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  124.103204] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  124.103205] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  124.103206] test_klp_shadow_vars:   got expected NULL result
[  124.103207] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  124.103208] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  124.103209] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  124.103211] test_klp_shadow_vars:   got expected NULL result
[  124.103212] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  124.103213] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  124.103214] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  124.103215] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  124.103216] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  124.103218] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  124.103231] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  124.103232] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  124.103233] test_klp_shadow_vars:   got expected NULL result
[  124.103234] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  124.103235] test_klp_shadow_vars:   got expected NULL result
[  124.103236] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  124.103238] test_klp_shadow_vars:   got expected NULL result
[  124.104546] % rmmod test_klp_shadow_vars
[  124.201338] livepatch: kernel.ftrace_enabled = 1
[  124.208997] ===== TEST: system state modification =====
[  124.212733] % modprobe test_klp_state
[  124.214788] livepatch: enabling patch 'test_klp_state'
[  124.214790] livepatch: 'test_klp_state': initializing patching transition
[  124.214811] test_klp_state: pre_patch_callback: vmlinux
[  124.214812] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  124.214814] livepatch: 'test_klp_state': starting patching transition
[  125.107324] livepatch: 'test_klp_state': completing patching transition
[  125.107502] test_klp_state: post_patch_callback: vmlinux
[  125.107504] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  125.107505] livepatch: 'test_klp_state': patching complete
[  125.132083] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  125.132120] livepatch: 'test_klp_state': initializing unpatching transition
[  125.132141] test_klp_state: pre_unpatch_callback: vmlinux
[  125.132142] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  125.132143] livepatch: 'test_klp_state': starting unpatching transition
[  125.987299] livepatch: 'test_klp_state': completing unpatching transition
[  125.987400] test_klp_state: post_unpatch_callback: vmlinux
[  125.987401] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  125.987402] livepatch: 'test_klp_state': unpatching complete
[  126.040767] % rmmod test_klp_state
[  126.104509] ===== TEST: taking over system state modification =====
[  126.107689] % modprobe test_klp_state
[  126.109150] livepatch: enabling patch 'test_klp_state'
[  126.109152] livepatch: 'test_klp_state': initializing patching transition
[  126.109173] test_klp_state: pre_patch_callback: vmlinux
[  126.109174] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  126.109176] livepatch: 'test_klp_state': starting patching transition
[  127.107325] livepatch: 'test_klp_state': completing patching transition
[  127.107431] test_klp_state: post_patch_callback: vmlinux
[  127.107432] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  127.107433] livepatch: 'test_klp_state': patching complete
[  127.131647] % modprobe test_klp_state2
[  127.133754] livepatch: enabling patch 'test_klp_state2'
[  127.133756] livepatch: 'test_klp_state2': initializing patching transition
[  127.133777] test_klp_state2: pre_patch_callback: vmlinux
[  127.133778] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  127.133779] livepatch: 'test_klp_state2': starting patching transition
[  127.987333] livepatch: 'test_klp_state2': completing patching transition
[  127.987456] test_klp_state2: post_patch_callback: vmlinux
[  127.987457] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  127.987458] livepatch: 'test_klp_state2': patching complete
[  128.051214] % rmmod test_klp_state
[  128.117089] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  128.117108] livepatch: 'test_klp_state2': initializing unpatching transition
[  128.117128] test_klp_state2: pre_unpatch_callback: vmlinux
[  128.117129] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  128.117131] livepatch: 'test_klp_state2': starting unpatching transition
[  129.027341] livepatch: 'test_klp_state2': completing unpatching transition
[  129.027447] test_klp_state2: post_unpatch_callback: vmlinux
[  129.027449] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  129.027451] livepatch: 'test_klp_state2': unpatching complete
[  129.127118] % rmmod test_klp_state2
[  129.194469] ===== TEST: compatible cumulative livepatches =====
[  129.197663] % modprobe test_klp_state2
[  129.199144] livepatch: enabling patch 'test_klp_state2'
[  129.199146] livepatch: 'test_klp_state2': initializing patching transition
[  129.199166] test_klp_state2: pre_patch_callback: vmlinux
[  129.199167] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  129.199168] livepatch: 'test_klp_state2': starting patching transition
[  130.707290] livepatch: 'test_klp_state2': completing patching transition
[  130.707484] test_klp_state2: post_patch_callback: vmlinux
[  130.707485] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  130.707486] livepatch: 'test_klp_state2': patching complete
[  130.728829] % modprobe test_klp_state3
[  130.730860] livepatch: enabling patch 'test_klp_state3'
[  130.730863] livepatch: 'test_klp_state3': initializing patching transition
[  130.730883] test_klp_state3: pre_patch_callback: vmlinux
[  130.730884] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  130.730886] livepatch: 'test_klp_state3': starting patching transition
[  131.747404] livepatch: 'test_klp_state3': completing patching transition
[  131.747514] test_klp_state3: post_patch_callback: vmlinux
[  131.747516] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  131.747517] livepatch: 'test_klp_state3': patching complete
[  131.751280] % rmmod test_klp_state2
[  131.830254] % modprobe test_klp_state2
[  131.831912] livepatch: enabling patch 'test_klp_state2'
[  131.831914] livepatch: 'test_klp_state2': initializing patching transition
[  131.831932] test_klp_state2: pre_patch_callback: vmlinux
[  131.831933] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  131.831934] livepatch: 'test_klp_state2': starting patching transition
[  132.787297] livepatch: 'test_klp_state2': completing patching transition
[  132.787417] test_klp_state2: post_patch_callback: vmlinux
[  132.787418] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  132.787420] livepatch: 'test_klp_state2': patching complete
[  132.849950] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  132.850015] livepatch: 'test_klp_state2': initializing unpatching transition
[  132.850036] test_klp_state2: pre_unpatch_callback: vmlinux
[  132.850037] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  132.850038] livepatch: 'test_klp_state2': starting unpatching transition
[  133.907269] livepatch: 'test_klp_state2': completing unpatching transition
[  133.907403] test_klp_state2: post_unpatch_callback: vmlinux
[  133.907405] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  133.907406] livepatch: 'test_klp_state2': unpatching complete
[  133.960649] % rmmod test_klp_state2
[  134.007856] % rmmod test_klp_state3
[  134.074550] ===== TEST: incompatible cumulative livepatches =====
[  134.077882] % modprobe test_klp_state2
[  134.079476] livepatch: enabling patch 'test_klp_state2'
[  134.079478] livepatch: 'test_klp_state2': initializing patching transition
[  134.079498] test_klp_state2: pre_patch_callback: vmlinux
[  134.079499] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  134.079501] livepatch: 'test_klp_state2': starting patching transition
[  135.587306] livepatch: 'test_klp_state2': completing patching transition
[  135.587415] test_klp_state2: post_patch_callback: vmlinux
[  135.587417] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  135.587418] livepatch: 'test_klp_state2': patching complete
[  135.606549] % modprobe test_klp_state
[  135.608261] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  135.736937] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  135.736975] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  135.736992] livepatch: 'test_klp_state2': initializing unpatching transition
[  135.737013] test_klp_state2: pre_unpatch_callback: vmlinux
[  135.737014] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  135.737015] livepatch: 'test_klp_state2': starting unpatching transition
[  136.947325] livepatch: 'test_klp_state2': completing unpatching transition
[  136.947481] test_klp_state2: post_unpatch_callback: vmlinux
[  136.947482] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  136.947483] livepatch: 'test_klp_state2': unpatching complete
[  136.948539] % rmmod test_klp_state2
[  137.041414] livepatch: kernel.ftrace_enabled = 1
[  137.049296] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  137.051220] livepatch: kernel.ftrace_enabled = 0
[  137.051281] % modprobe test_klp_livepatch
[  137.052860] livepatch: enabling patch 'test_klp_livepatch'
[  137.052862] livepatch: 'test_klp_livepatch': initializing patching transition
[  137.052885] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  137.052887] livepatch: failed to patch object 'vmlinux'
[  137.052888] livepatch: failed to enable patch 'test_klp_livepatch'
[  137.052889] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  137.052890] livepatch: 'test_klp_livepatch': completing unpatching transition
[  137.052996] livepatch: 'test_klp_livepatch': unpatching complete
[  137.176943] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  137.178976] livepatch: kernel.ftrace_enabled = 1
[  137.182231] % modprobe test_klp_livepatch
[  137.183760] livepatch: enabling patch 'test_klp_livepatch'
[  137.183762] livepatch: 'test_klp_livepatch': initializing patching transition
[  137.184843] livepatch: 'test_klp_livepatch': starting patching transition
[  138.067403] livepatch: 'test_klp_livepatch': completing patching transition
[  138.067507] livepatch: 'test_klp_livepatch': patching complete
[  138.105610] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  138.106627] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  138.106648] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  138.106672] livepatch: 'test_klp_livepatch': starting unpatching transition
[  139.107365] livepatch: 'test_klp_livepatch': completing unpatching transition
[  139.108879] livepatch: 'test_klp_livepatch': unpatching complete
[  139.116355] % rmmod test_klp_livepatch
[  139.200586] livepatch: kernel.ftrace_enabled = 1
[  139.208530] ===== TEST: sysfs test =====
[  139.211756] % modprobe test_klp_livepatch
[  139.213178] livepatch: enabling patch 'test_klp_livepatch'
[  139.213180] livepatch: 'test_klp_livepatch': initializing patching transition
[  139.214331] livepatch: 'test_klp_livepatch': starting patching transition
[  140.867306] livepatch: 'test_klp_livepatch': completing patching transition
[  140.867409] livepatch: 'test_klp_livepatch': patching complete
[  140.953991] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  140.954006] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  140.954028] livepatch: 'test_klp_livepatch': starting unpatching transition
[  141.997333] livepatch: 'test_klp_livepatch': completing unpatching transition
[  141.998940] livepatch: 'test_klp_livepatch': unpatching complete
[  142.064873] % rmmod test_klp_livepatch
[  142.144542] ===== TEST: sysfs test object/patched =====
[  142.147844] % modprobe test_klp_callbacks_demo
[  142.149314] livepatch: enabling patch 'test_klp_callbacks_demo'
[  142.149316] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  142.149336] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  142.149337] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  143.027295] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  143.027399] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  143.027400] livepatch: 'test_klp_callbacks_demo': patching complete
[  143.071068] % modprobe test_klp_callbacks_mod
[  143.072452] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  143.072454] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.072456] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.072497] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  143.074775] % rmmod test_klp_callbacks_mod
[  143.076064] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  143.076077] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.076079] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  143.076081] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.137979] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  143.138015] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  143.138036] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  143.138038] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  144.147343] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  144.147528] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  144.147530] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  144.249115] % rmmod test_klp_callbacks_demo
[  149.652836] livepatch: kernel.ftrace_enabled = 1
[  149.660651] ===== TEST: basic function patching =====
[  149.663714] % modprobe test_klp_livepatch
[  149.665324] livepatch: enabling patch 'test_klp_livepatch'
[  149.665326] livepatch: 'test_klp_livepatch': initializing patching transition
[  149.666432] livepatch: 'test_klp_livepatch': starting patching transition
[  151.027254] livepatch: 'test_klp_livepatch': completing patching transition
[  151.027390] livepatch: 'test_klp_livepatch': patching complete
[  151.092898] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  151.092917] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  151.092934] livepatch: 'test_klp_livepatch': starting unpatching transition
[  152.067265] livepatch: 'test_klp_livepatch': completing unpatching transition
[  152.068794] livepatch: 'test_klp_livepatch': unpatching complete
[  152.102901] % rmmod test_klp_livepatch
[  152.175346] ===== TEST: multiple livepatches =====
[  152.178402] % modprobe test_klp_livepatch
[  152.179854] livepatch: enabling patch 'test_klp_livepatch'
[  152.179857] livepatch: 'test_klp_livepatch': initializing patching transition
[  152.181052] livepatch: 'test_klp_livepatch': starting patching transition
[  153.587227] livepatch: 'test_klp_livepatch': completing patching transition
[  153.587346] livepatch: 'test_klp_livepatch': patching complete
[  153.605914] test_klp_livepatch: this has been live patched
[  153.610106] % modprobe test_klp_atomic_replace replace=0
[  153.611743] livepatch: enabling patch 'test_klp_atomic_replace'
[  153.611746] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  153.612988] livepatch: 'test_klp_atomic_replace': starting patching transition
[  154.867269] livepatch: 'test_klp_atomic_replace': completing patching transition
[  154.867427] livepatch: 'test_klp_atomic_replace': patching complete
[  154.936390] test_klp_livepatch: this has been live patched
[  154.937249] test_klp_atomic_replace: this has been live patched
[  154.937424] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  154.937443] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  154.937463] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  156.067196] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  156.068608] livepatch: 'test_klp_atomic_replace': unpatching complete
[  156.148189] % rmmod test_klp_atomic_replace
[  156.197593] test_klp_livepatch: this has been live patched
[  156.198534] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  156.198551] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  156.198569] livepatch: 'test_klp_livepatch': starting unpatching transition
[  157.027245] livepatch: 'test_klp_livepatch': completing unpatching transition
[  157.028678] livepatch: 'test_klp_livepatch': unpatching complete
[  157.107307] % rmmod test_klp_livepatch
[  157.196290] ===== TEST: atomic replace livepatch =====
[  157.199586] % modprobe test_klp_livepatch
[  157.201016] livepatch: enabling patch 'test_klp_livepatch'
[  157.201018] livepatch: 'test_klp_livepatch': initializing patching transition
[  157.202113] livepatch: 'test_klp_livepatch': starting patching transition
[  159.027189] livepatch: 'test_klp_livepatch': completing patching transition
[  159.027295] livepatch: 'test_klp_livepatch': patching complete
[  159.033053] test_klp_livepatch: this has been live patched
[  159.037594] % modprobe test_klp_atomic_replace replace=1
[  159.039272] livepatch: enabling patch 'test_klp_atomic_replace'
[  159.039274] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  159.040394] livepatch: 'test_klp_atomic_replace': starting patching transition
[  160.627247] livepatch: 'test_klp_atomic_replace': completing patching transition
[  160.628733] livepatch: 'test_klp_atomic_replace': patching complete
[  160.669276] test_klp_atomic_replace: this has been live patched
[  160.670250] % rmmod test_klp_livepatch
[  160.728472] test_klp_atomic_replace: this has been live patched
[  160.728578] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  160.728647] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  160.728675] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  162.067222] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  162.068711] livepatch: 'test_klp_atomic_replace': unpatching complete
[  162.140945] % rmmod test_klp_atomic_replace
[  162.231887] livepatch: kernel.ftrace_enabled = 1
[  162.239588] ===== TEST: target module before livepatch =====
[  162.242938] % modprobe test_klp_callbacks_mod
[  162.244287] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  162.247833] % modprobe test_klp_callbacks_demo
[  162.249367] livepatch: enabling patch 'test_klp_callbacks_demo'
[  162.249369] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  162.249388] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  162.249389] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  162.249406] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  163.747295] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  163.747452] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  163.747454] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  163.747456] livepatch: 'test_klp_callbacks_demo': patching complete
[  163.776543] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  163.776563] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  163.776586] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  163.776587] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  163.776589] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  165.027266] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  165.027372] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  165.027374] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  165.027375] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  165.088636] % rmmod test_klp_callbacks_demo
[  165.147720] % rmmod test_klp_callbacks_mod
[  165.148920] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  165.243998] ===== TEST: module_coming notifier =====
[  165.247169] % modprobe test_klp_callbacks_demo
[  165.248711] livepatch: enabling patch 'test_klp_callbacks_demo'
[  165.248713] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  165.248734] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  165.248735] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  166.707205] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  166.707378] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  166.707380] livepatch: 'test_klp_callbacks_demo': patching complete
[  166.778763] % modprobe test_klp_callbacks_mod
[  166.780198] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  166.780201] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  166.780203] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  166.780245] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  166.780610] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  166.780628] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  166.780649] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  166.780650] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  166.780652] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  168.067171] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  168.067288] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  168.067289] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  168.067291] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  168.092769] % rmmod test_klp_callbacks_demo
[  168.137636] % rmmod test_klp_callbacks_mod
[  168.138733] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  168.214554] ===== TEST: module_going notifier =====
[  168.217657] % modprobe test_klp_callbacks_mod
[  168.219088] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  168.222668] % modprobe test_klp_callbacks_demo
[  168.224189] livepatch: enabling patch 'test_klp_callbacks_demo'
[  168.224190] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  168.224209] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  168.224210] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  168.224211] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  169.027192] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  169.027294] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  169.027296] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  169.027297] livepatch: 'test_klp_callbacks_demo': patching complete
[  169.039955] % rmmod test_klp_callbacks_mod
[  169.041211] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  169.041225] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  169.041227] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  169.041229] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  169.096825] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  169.096842] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  169.096860] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  169.096861] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  170.067135] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  170.067237] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  170.067239] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  170.106247] % rmmod test_klp_callbacks_demo
[  170.184203] ===== TEST: module_coming and module_going notifiers =====
[  170.187291] % modprobe test_klp_callbacks_demo
[  170.188838] livepatch: enabling patch 'test_klp_callbacks_demo'
[  170.188840] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  170.188861] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  170.188862] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  171.837198] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  171.837326] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  171.837328] livepatch: 'test_klp_callbacks_demo': patching complete
[  171.921732] % modprobe test_klp_callbacks_mod
[  171.923091] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  171.923094] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  171.923096] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  171.923138] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  171.924441] % rmmod test_klp_callbacks_mod
[  171.925535] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  171.925548] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  171.925550] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  171.925551] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  171.966871] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  171.966889] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  171.966909] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  171.966910] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  173.027199] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  173.027354] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  173.027355] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  173.076841] % rmmod test_klp_callbacks_demo
[  173.144067] ===== TEST: target module not present =====
[  173.147097] % modprobe test_klp_callbacks_demo
[  173.148676] livepatch: enabling patch 'test_klp_callbacks_demo'
[  173.148678] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  173.148717] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  173.148719] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  174.627151] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  174.627256] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  174.627257] livepatch: 'test_klp_callbacks_demo': patching complete
[  174.675094] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  174.675112] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  174.675133] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  174.675134] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  176.067150] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  176.067252] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  176.067253] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  176.088083] % rmmod test_klp_callbacks_demo
[  176.194636] ===== TEST: pre-patch callback -ENODEV =====
[  176.197807] % modprobe test_klp_callbacks_mod
[  176.199160] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  176.199520] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  176.201031] livepatch: enabling patch 'test_klp_callbacks_demo'
[  176.201033] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  176.201061] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  176.201062] livepatch: pre-patch callback failed for object 'vmlinux'
[  176.201063] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  176.201064] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  176.201079] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  176.201187] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  176.346872] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  176.347900] % rmmod test_klp_callbacks_mod
[  176.349044] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  176.424402] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  176.427567] % modprobe test_klp_callbacks_demo
[  176.429103] livepatch: enabling patch 'test_klp_callbacks_demo'
[  176.429105] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  176.429125] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  176.429126] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  177.667156] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  177.667260] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  177.667261] livepatch: 'test_klp_callbacks_demo': patching complete
[  177.753119] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  177.754056] % modprobe test_klp_callbacks_mod
[  177.755378] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  177.755381] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  177.755383] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  177.755385] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  177.846782] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  177.846853] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  177.846869] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  177.846891] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  177.846892] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  179.027108] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  179.027212] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  179.027214] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  179.058400] % rmmod test_klp_callbacks_demo
[  179.124598] ===== TEST: multiple target modules =====
[  179.127765] % modprobe test_klp_callbacks_busy block_transition=N
[  179.129305] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  179.129311] test_klp_callbacks_busy: busymod_work_func enter
[  179.129313] test_klp_callbacks_busy: busymod_work_func exit
[  179.132729] % modprobe test_klp_callbacks_demo
[  179.134243] livepatch: enabling patch 'test_klp_callbacks_demo'
[  179.134247] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  179.134267] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  179.134268] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  179.135680] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  180.947100] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  180.947201] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  180.947203] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  180.947204] livepatch: 'test_klp_callbacks_demo': patching complete
[  180.970719] % modprobe test_klp_callbacks_mod
[  180.972226] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  180.972228] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  180.972230] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  180.972273] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  180.973615] % rmmod test_klp_callbacks_mod
[  180.974736] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  180.974748] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  180.974750] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  180.974751] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  181.046824] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  181.046842] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  181.046860] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  181.046861] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  181.046863] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  181.907102] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  181.908849] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  181.908851] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  181.908853] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  181.955928] % rmmod test_klp_callbacks_demo
[  182.057660] % rmmod test_klp_callbacks_busy
[  182.058777] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  182.134704] ===== TEST: busy target module =====
[  182.137780] % modprobe test_klp_callbacks_busy block_transition=Y
[  182.139259] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  182.139263] test_klp_callbacks_busy: busymod_work_func enter
[  182.142889] % modprobe test_klp_callbacks_demo
[  182.144362] livepatch: enabling patch 'test_klp_callbacks_demo'
[  182.144364] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  182.144382] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  182.144383] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  182.145742] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  182.150873] % modprobe test_klp_callbacks_mod
[  182.152293] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  182.152296] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  182.152339] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  182.153479] % rmmod test_klp_callbacks_mod
[  182.154578] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  182.154591] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  182.154592] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  182.196952] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  182.196973] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  182.197122] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  184.947083] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  184.948859] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  184.948861] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  184.948862] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  185.020008] % rmmod test_klp_callbacks_demo
[  185.077670] % rmmod test_klp_callbacks_busy
[  185.106398] test_klp_callbacks_busy: busymod_work_func exit
[  185.106407] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  185.184323] ===== TEST: multiple livepatches =====
[  185.187426] % modprobe test_klp_callbacks_demo
[  185.188999] livepatch: enabling patch 'test_klp_callbacks_demo'
[  185.189001] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  185.189021] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  185.189022] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  186.067143] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  186.067283] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  186.067284] livepatch: 'test_klp_callbacks_demo': patching complete
[  186.109240] % modprobe test_klp_callbacks_demo2
[  186.110881] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  186.110883] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  186.110904] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  186.110906] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  187.107240] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  187.107352] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  187.107353] livepatch: 'test_klp_callbacks_demo2': patching complete
[  187.129168] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  187.129188] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  187.129208] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  187.129209] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  187.987516] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  187.987618] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  187.987620] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  188.037170] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  188.037188] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  188.037205] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  188.037206] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  189.027062] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  189.027164] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  189.027166] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  189.047265] % rmmod test_klp_callbacks_demo2
[  189.137664] % rmmod test_klp_callbacks_demo
[  189.224455] ===== TEST: atomic replace =====
[  189.227586] % modprobe test_klp_callbacks_demo
[  189.229201] livepatch: enabling patch 'test_klp_callbacks_demo'
[  189.229203] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  189.229222] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  189.229224] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  190.067084] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  190.067235] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  190.067237] livepatch: 'test_klp_callbacks_demo': patching complete
[  190.148887] % modprobe test_klp_callbacks_demo2 replace=1
[  190.150416] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  190.150419] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  190.150439] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  190.150441] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  191.747107] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  191.747218] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  191.747220] livepatch: 'test_klp_callbacks_demo2': patching complete
[  191.778578] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  191.778598] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  191.778619] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  191.778621] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  192.947121] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  192.947227] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  192.947229] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  192.989892] % rmmod test_klp_callbacks_demo2
[  193.057940] % rmmod test_klp_callbacks_demo
[  193.160197] livepatch: kernel.ftrace_enabled = 1
[  193.167730] ===== TEST: basic shadow variable API =====
[  193.170833] % modprobe test_klp_shadow_vars
[  193.172209] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  193.172211] test_klp_shadow_vars:   got expected NULL result
[  193.172213] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  193.172214] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  193.172217] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  193.172218] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  193.172220] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  193.172221] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  193.172224] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  193.172225] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  193.172227] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  193.172229] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  193.172231] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  193.172232] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  193.172234] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  193.172236] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  193.172237] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  193.172238] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  193.172239] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  193.172240] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  193.172241] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  193.172243] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  193.172244] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  193.172245] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  193.172246] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  193.172247] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  193.172249] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  193.172251] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  193.172252] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  193.172254] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  193.172255] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  193.172257] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  193.172258] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  193.172260] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  193.172261] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  193.172262] test_klp_shadow_vars:   got expected NULL result
[  193.172263] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  193.172265] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  193.172266] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  193.172267] test_klp_shadow_vars:   got expected NULL result
[  193.172268] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  193.172269] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  193.172270] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  193.172271] test_klp_shadow_vars:   got expected NULL result
[  193.172272] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  193.172274] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  193.172275] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  193.172276] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  193.172277] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  193.172278] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  193.172287] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  193.172288] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  193.172289] test_klp_shadow_vars:   got expected NULL result
[  193.172290] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  193.172291] test_klp_shadow_vars:   got expected NULL result
[  193.172292] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  193.172293] test_klp_shadow_vars:   got expected NULL result
[  193.173588] % rmmod test_klp_shadow_vars
[  193.270211] livepatch: kernel.ftrace_enabled = 1
[  193.277772] ===== TEST: system state modification =====
[  193.280982] % modprobe test_klp_state
[  193.282421] livepatch: enabling patch 'test_klp_state'
[  193.282422] livepatch: 'test_klp_state': initializing patching transition
[  193.282443] test_klp_state: pre_patch_callback: vmlinux
[  193.282444] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  193.282445] livepatch: 'test_klp_state': starting patching transition
[  194.627016] livepatch: 'test_klp_state': completing patching transition
[  194.627121] test_klp_state: post_patch_callback: vmlinux
[  194.627122] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  194.627123] livepatch: 'test_klp_state': patching complete
[  194.707923] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  194.707943] livepatch: 'test_klp_state': initializing unpatching transition
[  194.707962] test_klp_state: pre_unpatch_callback: vmlinux
[  194.707963] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  194.707964] livepatch: 'test_klp_state': starting unpatching transition
[  195.667037] livepatch: 'test_klp_state': completing unpatching transition
[  195.667141] test_klp_state: post_unpatch_callback: vmlinux
[  195.667143] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  195.667144] livepatch: 'test_klp_state': unpatching complete
[  195.718014] % rmmod test_klp_state
[  195.794830] ===== TEST: taking over system state modification =====
[  195.797971] % modprobe test_klp_state
[  195.799572] livepatch: enabling patch 'test_klp_state'
[  195.799574] livepatch: 'test_klp_state': initializing patching transition
[  195.799595] test_klp_state: pre_patch_callback: vmlinux
[  195.799596] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  195.799598] livepatch: 'test_klp_state': starting patching transition
[  196.867056] livepatch: 'test_klp_state': completing patching transition
[  196.867162] test_klp_state: post_patch_callback: vmlinux
[  196.867164] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  196.867165] livepatch: 'test_klp_state': patching complete
[  196.922499] % modprobe test_klp_state2
[  196.924010] livepatch: enabling patch 'test_klp_state2'
[  196.924012] livepatch: 'test_klp_state2': initializing patching transition
[  196.924032] test_klp_state2: pre_patch_callback: vmlinux
[  196.924033] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  196.924034] livepatch: 'test_klp_state2': starting patching transition
[  198.627070] livepatch: 'test_klp_state2': completing patching transition
[  198.627227] test_klp_state2: post_patch_callback: vmlinux
[  198.627229] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  198.627230] livepatch: 'test_klp_state2': patching complete
[  198.654169] % rmmod test_klp_state
[  198.696775] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  198.696796] livepatch: 'test_klp_state2': initializing unpatching transition
[  198.696818] test_klp_state2: pre_unpatch_callback: vmlinux
[  198.696820] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  198.696821] livepatch: 'test_klp_state2': starting unpatching transition
[  199.667041] livepatch: 'test_klp_state2': completing unpatching transition
[  199.667222] test_klp_state2: post_unpatch_callback: vmlinux
[  199.667223] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  199.667224] livepatch: 'test_klp_state2': unpatching complete
[  199.706641] % rmmod test_klp_state2
[  199.794709] ===== TEST: compatible cumulative livepatches =====
[  199.797951] % modprobe test_klp_state2
[  199.799497] livepatch: enabling patch 'test_klp_state2'
[  199.799500] livepatch: 'test_klp_state2': initializing patching transition
[  199.799521] test_klp_state2: pre_patch_callback: vmlinux
[  199.799522] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  199.799524] livepatch: 'test_klp_state2': starting patching transition
[  200.707033] livepatch: 'test_klp_state2': completing patching transition
[  200.707156] test_klp_state2: post_patch_callback: vmlinux
[  200.707158] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  200.707159] livepatch: 'test_klp_state2': patching complete
[  200.719453] % modprobe test_klp_state3
[  200.721036] livepatch: enabling patch 'test_klp_state3'
[  200.721040] livepatch: 'test_klp_state3': initializing patching transition
[  200.721063] test_klp_state3: pre_patch_callback: vmlinux
[  200.721064] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  200.721065] livepatch: 'test_klp_state3': starting patching transition
[  201.667030] livepatch: 'test_klp_state3': completing patching transition
[  201.667132] test_klp_state3: post_patch_callback: vmlinux
[  201.667134] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  201.667135] livepatch: 'test_klp_state3': patching complete
[  201.740654] % rmmod test_klp_state2
[  201.790108] % modprobe test_klp_state2
[  201.791613] livepatch: enabling patch 'test_klp_state2'
[  201.791616] livepatch: 'test_klp_state2': initializing patching transition
[  201.791636] test_klp_state2: pre_patch_callback: vmlinux
[  201.791637] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  201.791639] livepatch: 'test_klp_state2': starting patching transition
[  202.947001] livepatch: 'test_klp_state2': completing patching transition
[  202.947134] test_klp_state2: post_patch_callback: vmlinux
[  202.947136] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  202.947137] livepatch: 'test_klp_state2': patching complete
[  203.013457] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  203.013476] livepatch: 'test_klp_state2': initializing unpatching transition
[  203.013497] test_klp_state2: pre_unpatch_callback: vmlinux
[  203.013498] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  203.013499] livepatch: 'test_klp_state2': starting unpatching transition
[  204.627021] livepatch: 'test_klp_state2': completing unpatching transition
[  204.627127] test_klp_state2: post_unpatch_callback: vmlinux
[  204.627128] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  204.627130] livepatch: 'test_klp_state2': unpatching complete
[  204.628240] % rmmod test_klp_state2
[  204.677492] % rmmod test_klp_state3
[  204.754498] ===== TEST: incompatible cumulative livepatches =====
[  204.757803] % modprobe test_klp_state2
[  204.759469] livepatch: enabling patch 'test_klp_state2'
[  204.759471] livepatch: 'test_klp_state2': initializing patching transition
[  204.759509] test_klp_state2: pre_patch_callback: vmlinux
[  204.759511] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  204.759512] livepatch: 'test_klp_state2': starting patching transition
[  205.667054] livepatch: 'test_klp_state2': completing patching transition
[  205.667221] test_klp_state2: post_patch_callback: vmlinux
[  205.667223] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  205.667224] livepatch: 'test_klp_state2': patching complete
[  205.676418] % modprobe test_klp_state
[  205.678021] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  205.796666] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  205.796711] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  205.796727] livepatch: 'test_klp_state2': initializing unpatching transition
[  205.796748] test_klp_state2: pre_unpatch_callback: vmlinux
[  205.796749] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  205.796750] livepatch: 'test_klp_state2': starting unpatching transition
[  206.627024] livepatch: 'test_klp_state2': completing unpatching transition
[  206.627126] test_klp_state2: post_unpatch_callback: vmlinux
[  206.627127] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  206.627128] livepatch: 'test_klp_state2': unpatching complete
[  206.705649] % rmmod test_klp_state2
[  206.799832] livepatch: kernel.ftrace_enabled = 1
[  206.807523] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  206.809453] livepatch: kernel.ftrace_enabled = 0
[  206.809519] % modprobe test_klp_livepatch
[  206.811132] livepatch: enabling patch 'test_klp_livepatch'
[  206.811134] livepatch: 'test_klp_livepatch': initializing patching transition
[  206.811157] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  206.811159] livepatch: failed to patch object 'vmlinux'
[  206.811160] livepatch: failed to enable patch 'test_klp_livepatch'
[  206.811161] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  206.811162] livepatch: 'test_klp_livepatch': completing unpatching transition
[  206.811267] livepatch: 'test_klp_livepatch': unpatching complete
[  206.946752] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  206.948665] livepatch: kernel.ftrace_enabled = 1
[  206.951864] % modprobe test_klp_livepatch
[  206.953500] livepatch: enabling patch 'test_klp_livepatch'
[  206.953502] livepatch: 'test_klp_livepatch': initializing patching transition
[  206.954621] livepatch: 'test_klp_livepatch': starting patching transition
[  208.147074] livepatch: 'test_klp_livepatch': completing patching transition
[  208.147180] livepatch: 'test_klp_livepatch': patching complete
[  208.181130] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  208.182202] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  208.182223] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  208.182241] livepatch: 'test_klp_livepatch': starting unpatching transition
[  209.106989] livepatch: 'test_klp_livepatch': completing unpatching transition
[  209.108516] livepatch: 'test_klp_livepatch': unpatching complete
[  209.192468] % rmmod test_klp_livepatch
[  209.269412] livepatch: kernel.ftrace_enabled = 1
[  209.277289] ===== TEST: sysfs test =====
[  209.280562] % modprobe test_klp_livepatch
[  209.282041] livepatch: enabling patch 'test_klp_livepatch'
[  209.282043] livepatch: 'test_klp_livepatch': initializing patching transition
[  209.283130] livepatch: 'test_klp_livepatch': starting patching transition
[  210.946994] livepatch: 'test_klp_livepatch': completing patching transition
[  210.947096] livepatch: 'test_klp_livepatch': patching complete
[  211.020069] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  211.020084] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  211.020103] livepatch: 'test_klp_livepatch': starting unpatching transition
[  211.906955] livepatch: 'test_klp_livepatch': completing unpatching transition
[  211.908429] livepatch: 'test_klp_livepatch': unpatching complete
[  211.928959] % rmmod test_klp_livepatch
[  212.004690] ===== TEST: sysfs test object/patched =====
[  212.007954] % modprobe test_klp_callbacks_demo
[  212.009626] livepatch: enabling patch 'test_klp_callbacks_demo'
[  212.009628] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  212.009649] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  212.009650] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  213.106985] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  213.107148] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  213.107150] livepatch: 'test_klp_callbacks_demo': patching complete
[  213.133983] % modprobe test_klp_callbacks_mod
[  213.135432] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  213.135434] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  213.135436] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  213.135478] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  213.137671] % rmmod test_klp_callbacks_mod
[  213.138782] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  213.138796] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  213.138798] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  213.138799] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  213.187620] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  213.187639] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  213.187660] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  213.187661] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  214.956966] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  214.957069] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  214.957070] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  215.004034] % rmmod test_klp_callbacks_demo
[  216.486413] livepatch: kernel.ftrace_enabled = 1
[  216.494184] ===== TEST: basic function patching =====
[  216.497478] % modprobe test_klp_livepatch
[  216.499123] livepatch: enabling patch 'test_klp_livepatch'
[  216.499125] livepatch: 'test_klp_livepatch': initializing patching transition
[  216.500232] livepatch: 'test_klp_livepatch': starting patching transition
[  217.906980] livepatch: 'test_klp_livepatch': completing patching transition
[  217.907138] livepatch: 'test_klp_livepatch': patching complete
[  217.927548] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  217.927569] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  217.927590] livepatch: 'test_klp_livepatch': starting unpatching transition
[  218.947043] livepatch: 'test_klp_livepatch': completing unpatching transition
[  218.948644] livepatch: 'test_klp_livepatch': unpatching complete
[  219.038726] % rmmod test_klp_livepatch
[  219.115033] ===== TEST: multiple livepatches =====
[  219.118186] % modprobe test_klp_livepatch
[  219.119788] livepatch: enabling patch 'test_klp_livepatch'
[  219.119790] livepatch: 'test_klp_livepatch': initializing patching transition
[  219.120986] livepatch: 'test_klp_livepatch': starting patching transition
[  220.866989] livepatch: 'test_klp_livepatch': completing patching transition
[  220.867145] livepatch: 'test_klp_livepatch': patching complete
[  220.952783] test_klp_livepatch: this has been live patched
[  220.957044] % modprobe test_klp_atomic_replace replace=0
[  220.958580] livepatch: enabling patch 'test_klp_atomic_replace'
[  220.958582] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  220.959660] livepatch: 'test_klp_atomic_replace': starting patching transition
[  221.826984] livepatch: 'test_klp_atomic_replace': completing patching transition
[  221.827087] livepatch: 'test_klp_atomic_replace': patching complete
[  221.877823] test_klp_livepatch: this has been live patched
[  221.878665] test_klp_atomic_replace: this has been live patched
[  221.878801] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  221.878822] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  221.878843] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  222.947011] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  222.948465] livepatch: 'test_klp_atomic_replace': unpatching complete
[  222.989788] % rmmod test_klp_atomic_replace
[  223.047531] test_klp_livepatch: this has been live patched
[  223.048613] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  223.048632] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  223.048654] livepatch: 'test_klp_livepatch': starting unpatching transition
[  223.987012] livepatch: 'test_klp_livepatch': completing unpatching transition
[  223.988534] livepatch: 'test_klp_livepatch': unpatching complete
[  224.059000] % rmmod test_klp_livepatch
[  224.156318] ===== TEST: atomic replace livepatch =====
[  224.159489] % modprobe test_klp_livepatch
[  224.160923] livepatch: enabling patch 'test_klp_livepatch'
[  224.160926] livepatch: 'test_klp_livepatch': initializing patching transition
[  224.162024] livepatch: 'test_klp_livepatch': starting patching transition
[  225.666965] livepatch: 'test_klp_livepatch': completing patching transition
[  225.667118] livepatch: 'test_klp_livepatch': patching complete
[  225.689716] test_klp_livepatch: this has been live patched
[  225.693937] % modprobe test_klp_atomic_replace replace=1
[  225.695517] livepatch: enabling patch 'test_klp_atomic_replace'
[  225.695519] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  225.696644] livepatch: 'test_klp_atomic_replace': starting patching transition
[  226.786967] livepatch: 'test_klp_atomic_replace': completing patching transition
[  226.788286] livepatch: 'test_klp_atomic_replace': patching complete
[  226.818010] test_klp_atomic_replace: this has been live patched
[  226.819031] % rmmod test_klp_livepatch
[  226.878235] test_klp_atomic_replace: this has been live patched
[  226.878402] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  226.878421] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  226.878443] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  227.907041] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  227.908601] livepatch: 'test_klp_atomic_replace': unpatching complete
[  227.988889] % rmmod test_klp_atomic_replace
[  228.081616] livepatch: kernel.ftrace_enabled = 1
[  228.089746] ===== TEST: target module before livepatch =====
[  228.093012] % modprobe test_klp_callbacks_mod
[  228.094389] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  228.097768] % modprobe test_klp_callbacks_demo
[  228.099261] livepatch: enabling patch 'test_klp_callbacks_demo'
[  228.099263] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  228.099286] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  228.099287] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  228.099289] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  229.027084] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  229.027196] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  229.027198] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  229.027199] livepatch: 'test_klp_callbacks_demo': patching complete
[  229.118464] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  229.118483] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  229.118504] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  229.118505] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  229.118506] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  230.866938] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  230.867117] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  230.867118] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  230.867120] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  230.935471] % rmmod test_klp_callbacks_demo
[  230.997625] % rmmod test_klp_callbacks_mod
[  230.998771] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  231.064190] ===== TEST: module_coming notifier =====
[  231.067155] % modprobe test_klp_callbacks_demo
[  231.068630] livepatch: enabling patch 'test_klp_callbacks_demo'
[  231.068632] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  231.068652] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  231.068653] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  232.786968] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  232.787122] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  232.787123] livepatch: 'test_klp_callbacks_demo': patching complete
[  232.800046] % modprobe test_klp_callbacks_mod
[  232.801418] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  232.801421] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  232.801423] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  232.801465] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  232.801808] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  232.801826] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  232.801848] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  232.801849] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  232.801850] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  233.906995] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  233.907137] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  233.907139] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  233.907140] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  233.912080] % rmmod test_klp_callbacks_demo
[  233.987482] % rmmod test_klp_callbacks_mod
[  233.988644] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  234.064216] ===== TEST: module_going notifier =====
[  234.067491] % modprobe test_klp_callbacks_mod
[  234.068784] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  234.072123] % modprobe test_klp_callbacks_demo
[  234.073590] livepatch: enabling patch 'test_klp_callbacks_demo'
[  234.073592] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  234.073611] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  234.073613] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  234.073614] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  234.866962] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  234.867066] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  234.867068] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  234.867069] livepatch: 'test_klp_callbacks_demo': patching complete
[  234.889218] % rmmod test_klp_callbacks_mod
[  234.890290] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  234.890303] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  234.890305] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  234.890307] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  234.936640] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  234.936658] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  234.936677] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  234.936678] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  235.906953] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  235.907059] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  235.907060] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  235.946374] % rmmod test_klp_callbacks_demo
[  236.044816] ===== TEST: module_coming and module_going notifiers =====
[  236.047961] % modprobe test_klp_callbacks_demo
[  236.049483] livepatch: enabling patch 'test_klp_callbacks_demo'
[  236.049485] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  236.049505] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  236.049506] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  236.947000] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  236.947176] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  236.947178] livepatch: 'test_klp_callbacks_demo': patching complete
[  236.969682] % modprobe test_klp_callbacks_mod
[  236.971078] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  236.971080] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  236.971082] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  236.971123] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  236.972339] % rmmod test_klp_callbacks_mod
[  236.973427] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  236.973439] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  236.973441] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  236.973442] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  237.036714] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  237.036732] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  237.036753] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  237.036754] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  237.906936] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  237.907087] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  237.907088] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  237.945408] % rmmod test_klp_callbacks_demo

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

[   12.425136] scsi 1:0:0:1084178561: scsi scan: INQUIRY successful with code 0x0
[   12.425141] scsi 1:0:0:1084178561: scsi scan: INQUIRY pass 2 length 164
[   12.425154] sd 1:0:0:1084113025: Power-on or device reset occurred
[   12.425157] sd 1:0:0:1084113025: [sdg] tag#1665 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.425159] sd 1:0:0:1084113025: [sdg] tag#1665 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.425161] sd 1:0:0:1084113025: [sdg] tag#1665 Sense Key : Unit Attention [current] 
[   12.425163] sd 1:0:0:1084113025: [sdg] tag#1665 Add. Sense: Power on, reset, or bus device reset occurred
[   12.425233] scsi 1:0:0:1084178561: scsi scan: INQUIRY successful with code 0x0
[   12.425238] scsi 1:0:0:1084178561: Direct-Access     IBM      2107900          .102 PQ: 0 ANSI: 6
[   12.426688] scsi 1:0:0:1084178561: alua: supports implicit TPGS
[   12.426691] scsi 1:0:0:1084178561: alua: device naa.6005076309ffd435000000000000819f port group 0 rel port 243
[   12.426934] sd 1:0:0:1084178561: sg_alloc: dev=7 
[   12.427059] sd 1:0:0:1084178561: Attached scsi generic sg7 type 0
[   12.427341] sd 1:0:0:1084113024: scsi scan: device exists on 1:0:0:1084113024
[   12.427411] sd 1:0:0:1084178561: Power-on or device reset occurred
[   12.427414] sd 1:0:0:1084178561: [sdh] tag#897 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.427417] sd 1:0:0:1084178561: [sdh] tag#897 CDB: Test Unit Ready 00 00 00 00 00 00
[   12.427419] sd 1:0:0:1084178561: [sdh] tag#897 Sense Key : Unit Attention [current] 
[   12.427422] sd 1:0:0:1084178561: [sdh] tag#897 Add. Sense: Power on, reset, or bus device reset occurred
[   12.427766] sd 1:0:0:1084178560: scsi scan: device exists on 1:0:0:1084178560
[   12.428386] sd 1:0:0:1084113025: scsi scan: device exists on 1:0:0:1084113025
[   12.428806] sd 1:0:0:1084178561: scsi scan: device exists on 1:0:0:1084178561
[   12.440305] sd 1:0:0:1084113025: [sdg] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440309] sd 1:0:0:1084113024: [sde] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440328] sd 1:0:0:1084178561: [sdh] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440365] sd 1:0:0:1084178560: [sdf] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[   12.440405] sd 1:0:0:1084113025: [sdg] Write Protect is off
[   12.440406] sd 1:0:0:1084113025: [sdg] Mode Sense: ed 00 00 08
[   12.440408] sd 1:0:0:1084113024: [sde] Write Protect is off
[   12.440410] sd 1:0:0:1084113024: [sde] Mode Sense: ed 00 00 08
[   12.440426] sd 1:0:0:1084178561: [sdh] Write Protect is off
[   12.440428] sd 1:0:0:1084178561: [sdh] Mode Sense: ed 00 00 08
[   12.440451] sd 1:0:0:1084178560: [sdf] Write Protect is off
[   12.440453] sd 1:0:0:1084178560: [sdf] Mode Sense: ed 00 00 08
[   12.440613] sd 1:0:0:1084113025: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440615] sd 1:0:0:1084113024: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440625] sd 1:0:0:1084178561: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440627] sd 1:0:0:1084178560: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.440709] sd 1:0:0:1084113024: [sde] tag#2055 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440712] sd 1:0:0:1084113024: [sde] tag#2055 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440714] sd 1:0:0:1084113024: [sde] tag#2055 Sense Key : Illegal Request [current] 
[   12.440716] sd 1:0:0:1084113024: [sde] tag#2055 Add. Sense: Invalid field in cdb
[   12.440722] sd 1:0:0:1084178560: [sdf] tag#906 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440724] sd 1:0:0:1084178560: [sdf] tag#906 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440727] sd 1:0:0:1084178560: [sdf] tag#906 Sense Key : Illegal Request [current] 
[   12.440729] sd 1:0:0:1084178560: [sdf] tag#906 Add. Sense: Invalid field in cdb
[   12.440826] sd 1:0:0:1084113025: [sdg] tag#1677 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440846] sd 1:0:0:1084113025: [sdg] tag#1677 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440849] sd 1:0:0:1084113025: [sdg] tag#1677 Sense Key : Illegal Request [current] 
[   12.440851] sd 1:0:0:1084113025: [sdg] tag#1677 Add. Sense: Invalid field in cdb
[   12.440855] sd 1:0:0:1084113025: [sdg] Disabling DIF Type 1 protection
[   12.440857] sd 1:0:0:1084113025: [sdg] Enabling DIF Type 0 protection
[   12.440861] sd 1:0:0:1084178561: [sdh] tag#325 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.440874] sd 1:0:0:1084178561: [sdh] tag#325 CDB: Report supported operation codes a3 0c 01 12 00 00 00 00 00 0a 00 00
[   12.440881] sd 1:0:0:1084178561: [sdh] tag#325 Sense Key : Illegal Request [current] 
[   12.440882] sd 1:0:0:1084178561: [sdh] tag#325 Add. Sense: Invalid field in cdb
[   12.440886] sd 1:0:0:1084178561: [sdh] Disabling DIF Type 1 protection
[   12.440888] sd 1:0:0:1084178561: [sdh] Enabling DIF Type 0 protection
[   12.443759] sd 1:0:0:1084113024: [sde] tag#1679 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443780] sd 1:0:0:1084113024: [sde] tag#1679 CDB: Inquiry 12 01 b9 00 04 00
[   12.443782] sd 1:0:0:1084113024: [sde] tag#1679 Sense Key : Illegal Request [current] 
[   12.443785] sd 1:0:0:1084113024: [sde] tag#1679 Add. Sense: Invalid field in cdb
[   12.443797] sd 1:0:0:1084178560: [sdf] tag#327 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443800] sd 1:0:0:1084178560: [sdf] tag#327 CDB: Inquiry 12 01 b9 00 04 00
[   12.443802] sd 1:0:0:1084178560: [sdf] tag#327 Sense Key : Illegal Request [current] 
[   12.443805] sd 1:0:0:1084178560: [sdf] tag#327 Add. Sense: Invalid field in cdb
[   12.443902] sd 1:0:0:1084113025: [sdg] tag#1682 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443905] sd 1:0:0:1084113025: [sdg] tag#1682 CDB: Inquiry 12 01 b9 00 04 00
[   12.443908] sd 1:0:0:1084113025: [sdg] tag#1682 Sense Key : Illegal Request [current] 
[   12.443910] sd 1:0:0:1084113025: [sdg] tag#1682 Add. Sense: Invalid field in cdb
[   12.443912] sd 1:0:0:1084178561: [sdh] tag#2057 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[   12.443917] sd 1:0:0:1084178561: [sdh] tag#2057 CDB: Inquiry 12 01 b9 00 04 00
[   12.443919] sd 1:0:0:1084178561: [sdh] tag#2057 Sense Key : Illegal Request [current] 
[   12.443921] sd 1:0:0:1084178561: [sdh] tag#2057 Add. Sense: Invalid field in cdb
[   12.444277] sd 1:0:0:1084178560: [sdf] Attached SCSI disk
[   12.444413] sd 1:0:0:1084113025: [sdg] Attached SCSI disk
[   12.444437] sd 1:0:0:1084178561: [sdh] Attached SCSI disk
[   12.445055]  sde: sde1
[   12.445135] sd 1:0:0:1084113024: [sde] Attached SCSI disk
[   12.455157] mlx5_core 0001:00:00.0 ens8192f0np0: Link up
[   12.754503] mlx5_core 0000:00:00.0 ens8320f0np0: Link up
[   12.870161] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.871810] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.873288] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.879490] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.881609] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   12.883524] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   13.129973] systemd-journald[943]: Compressed data object 621 -> 266 using ZSTD
[   13.130596] systemd-journald[943]: Compressed data object 621 -> 274 using ZSTD
[   14.130283] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   52.526889] crw_info : CRW reports slct=0, oflw=0, chn=0, rsc=B, anc=0, erc=0, rsid=0
[   64.832872] systemd-journald[943]: Compressed data object 533 -> 400 using ZSTD
[   64.919285] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   64.928008] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   65.045916] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   65.046557] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   65.206974] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
[   84.040569] livepatch: kernel.ftrace_enabled = 1
[   84.047983] ===== TEST: basic function patching =====
[   84.052146] % modprobe test_klp_livepatch
[   84.054139] test_klp_livepatch: tainting kernel with TAINT_LIVEPATCH
[   84.054277] livepatch: enabling patch 'test_klp_livepatch'
[   84.054279] livepatch: 'test_klp_livepatch': initializing patching transition
[   84.055514] livepatch: 'test_klp_livepatch': starting patching transition
[   84.867407] livepatch: 'test_klp_livepatch': completing patching transition
[   84.867542] livepatch: 'test_klp_livepatch': patching complete
[   84.872840] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[   84.872891] livepatch: 'test_klp_livepatch': initializing unpatching transition
[   84.872925] livepatch: 'test_klp_livepatch': starting unpatching transition
[   85.987407] livepatch: 'test_klp_livepatch': completing unpatching transition
[   85.989034] livepatch: 'test_klp_livepatch': unpatching complete
[   86.084797] % rmmod test_klp_livepatch
[   86.153886] ===== TEST: multiple livepatches =====
[   86.157188] % modprobe test_klp_livepatch
[   86.158657] livepatch: enabling patch 'test_klp_livepatch'
[   86.158659] livepatch: 'test_klp_livepatch': initializing patching transition
[   86.159793] livepatch: 'test_klp_livepatch': starting patching transition
[   87.027437] livepatch: 'test_klp_livepatch': completing patching transition
[   87.027546] livepatch: 'test_klp_livepatch': patching complete
[   87.078385] test_klp_livepatch: this has been live patched
[   87.083290] % modprobe test_klp_atomic_replace replace=0
[   87.085500] livepatch: enabling patch 'test_klp_atomic_replace'
[   87.085502] livepatch: 'test_klp_atomic_replace': initializing patching transition
[   87.086685] livepatch: 'test_klp_atomic_replace': starting patching transition
[   87.907412] livepatch: 'test_klp_atomic_replace': completing patching transition
[   87.907555] livepatch: 'test_klp_atomic_replace': patching complete
[   88.004547] test_klp_livepatch: this has been live patched
[   88.005509] test_klp_atomic_replace: this has been live patched
[   88.005634] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[   88.005721] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[   88.005740] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[   88.947422] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[   88.948800] livepatch: 'test_klp_atomic_replace': unpatching complete
[   89.016537] % rmmod test_klp_atomic_replace
[   89.097952] test_klp_livepatch: this has been live patched
[   89.099036] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[   89.099056] livepatch: 'test_klp_livepatch': initializing unpatching transition
[   89.099079] livepatch: 'test_klp_livepatch': starting unpatching transition
[   89.907443] livepatch: 'test_klp_livepatch': completing unpatching transition
[   89.908927] livepatch: 'test_klp_livepatch': unpatching complete
[   90.008993] % rmmod test_klp_livepatch
[   90.075281] ===== TEST: atomic replace livepatch =====
[   90.078563] % modprobe test_klp_livepatch
[   90.080025] livepatch: enabling patch 'test_klp_livepatch'
[   90.080027] livepatch: 'test_klp_livepatch': initializing patching transition
[   90.081063] livepatch: 'test_klp_livepatch': starting patching transition
[   91.667362] livepatch: 'test_klp_livepatch': completing patching transition
[   91.667466] livepatch: 'test_klp_livepatch': patching complete
[   91.711116] test_klp_livepatch: this has been live patched
[   91.715609] % modprobe test_klp_atomic_replace replace=1
[   91.717349] livepatch: enabling patch 'test_klp_atomic_replace'
[   91.717350] livepatch: 'test_klp_atomic_replace': initializing patching transition
[   91.718440] livepatch: 'test_klp_atomic_replace': starting patching transition
[   93.027449] livepatch: 'test_klp_atomic_replace': completing patching transition
[   93.028821] livepatch: 'test_klp_atomic_replace': patching complete
[   93.044211] test_klp_atomic_replace: this has been live patched
[   93.045414] % rmmod test_klp_livepatch
[   93.138826] test_klp_atomic_replace: this has been live patched
[   93.138945] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[   93.139013] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[   93.139039] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[   93.987388] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[   93.988892] livepatch: 'test_klp_atomic_replace': unpatching complete
[   94.048696] % rmmod test_klp_atomic_replace
[   94.131346] livepatch: kernel.ftrace_enabled = 1
[   94.138074] ===== TEST: target module before livepatch =====
[   94.141712] % modprobe test_klp_callbacks_mod
[   94.143390] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[   94.147450] % modprobe test_klp_callbacks_demo
[   94.149518] livepatch: enabling patch 'test_klp_callbacks_demo'
[   94.149520] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[   94.149584] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[   94.149585] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   94.149586] livepatch: 'test_klp_callbacks_demo': starting patching transition
[   95.827310] livepatch: 'test_klp_callbacks_demo': completing patching transition
[   95.827414] test_klp_callbacks_demo: post_patch_callback: vmlinux
[   95.827416] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   95.827417] livepatch: 'test_klp_callbacks_demo': patching complete
[   95.880751] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[   95.880770] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[   95.880792] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[   95.880793] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   95.880795] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[   96.947362] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[   96.947467] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[   96.947468] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   96.947470] livepatch: 'test_klp_callbacks_demo': unpatching complete
[   96.991491] % rmmod test_klp_callbacks_demo
[   97.047939] % rmmod test_klp_callbacks_mod
[   97.049129] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[   97.123448] ===== TEST: module_coming notifier =====
[   97.126706] % modprobe test_klp_callbacks_demo
[   97.128201] livepatch: enabling patch 'test_klp_callbacks_demo'
[   97.128202] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[   97.128221] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[   97.128222] livepatch: 'test_klp_callbacks_demo': starting patching transition
[   97.907366] livepatch: 'test_klp_callbacks_demo': completing patching transition
[   97.907523] test_klp_callbacks_demo: post_patch_callback: vmlinux
[   97.907524] livepatch: 'test_klp_callbacks_demo': patching complete
[   97.947504] % modprobe test_klp_callbacks_mod
[   97.948836] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[   97.948839] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[   97.948841] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[   97.948883] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[   97.949244] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[   97.949263] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[   97.949283] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[   97.949284] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   97.949285] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[   99.117355] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[   99.117458] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[   99.117460] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   99.117461] livepatch: 'test_klp_callbacks_demo': unpatching complete
[   99.160962] % rmmod test_klp_callbacks_demo
[   99.207962] % rmmod test_klp_callbacks_mod
[   99.209122] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[   99.283107] ===== TEST: module_going notifier =====
[   99.286635] % modprobe test_klp_callbacks_mod
[   99.288047] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[   99.291742] % modprobe test_klp_callbacks_demo
[   99.293440] livepatch: enabling patch 'test_klp_callbacks_demo'
[   99.293441] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[   99.293462] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[   99.293463] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   99.293465] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  101.027350] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  101.027455] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  101.027456] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  101.027458] livepatch: 'test_klp_callbacks_demo': patching complete
[  101.126745] % rmmod test_klp_callbacks_mod
[  101.127848] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  101.127863] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  101.127865] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  101.127866] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  101.187049] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  101.187066] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  101.187085] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  101.187086] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  102.067340] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  102.067461] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  102.067463] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  102.096546] % rmmod test_klp_callbacks_demo
[  102.183243] ===== TEST: module_coming and module_going notifiers =====
[  102.186391] % modprobe test_klp_callbacks_demo
[  102.187856] livepatch: enabling patch 'test_klp_callbacks_demo'
[  102.187858] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  102.187879] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  102.187881] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  103.827367] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  103.827510] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  103.827511] livepatch: 'test_klp_callbacks_demo': patching complete
[  103.920248] % modprobe test_klp_callbacks_mod
[  103.921535] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  103.921537] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  103.921539] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  103.921581] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  103.922691] % rmmod test_klp_callbacks_mod
[  103.923756] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  103.923786] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  103.923788] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  103.923789] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  103.987019] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  103.987036] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  103.987057] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  103.987058] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  105.027318] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  105.027425] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  105.027426] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  105.096960] % rmmod test_klp_callbacks_demo
[  105.193366] ===== TEST: target module not present =====
[  105.196426] % modprobe test_klp_callbacks_demo
[  105.197920] livepatch: enabling patch 'test_klp_callbacks_demo'
[  105.197923] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  105.197944] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  105.197945] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  106.957298] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  106.957421] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  106.957422] livepatch: 'test_klp_callbacks_demo': patching complete
[  107.027668] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  107.027687] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  107.027708] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  107.027709] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  108.067334] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  108.067440] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  108.067441] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  108.137719] % rmmod test_klp_callbacks_demo
[  108.213123] ===== TEST: pre-patch callback -ENODEV =====
[  108.216268] % modprobe test_klp_callbacks_mod
[  108.217645] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  108.218019] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  108.219501] livepatch: enabling patch 'test_klp_callbacks_demo'
[  108.219503] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  108.219523] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  108.219524] livepatch: pre-patch callback failed for object 'vmlinux'
[  108.219524] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  108.219526] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  108.219527] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  108.219633] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  108.366951] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  108.367826] % rmmod test_klp_callbacks_mod
[  108.368966] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  108.463160] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  108.466160] % modprobe test_klp_callbacks_demo
[  108.467614] livepatch: enabling patch 'test_klp_callbacks_demo'
[  108.467616] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  108.467638] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  108.467639] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  109.667362] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  109.667472] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  109.667473] livepatch: 'test_klp_callbacks_demo': patching complete
[  109.689019] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  109.689979] % modprobe test_klp_callbacks_mod
[  109.691291] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  109.691294] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  109.691296] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  109.691297] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  109.837006] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  109.837051] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  109.837066] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  109.837088] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  109.837089] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  111.027394] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  111.027554] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  111.027555] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  111.048716] % rmmod test_klp_callbacks_demo
[  111.124777] ===== TEST: multiple target modules =====
[  111.128696] % modprobe test_klp_callbacks_busy block_transition=N
[  111.130780] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  111.130784] test_klp_callbacks_busy: busymod_work_func enter
[  111.130786] test_klp_callbacks_busy: busymod_work_func exit
[  111.134478] % modprobe test_klp_callbacks_demo
[  111.135984] livepatch: enabling patch 'test_klp_callbacks_demo'
[  111.135986] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  111.136005] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  111.136006] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  111.137437] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  111.987405] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  111.987513] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  111.987515] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  111.987516] livepatch: 'test_klp_callbacks_demo': patching complete
[  112.058064] % modprobe test_klp_callbacks_mod
[  112.059514] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  112.059516] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  112.059518] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  112.059560] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  112.060788] % rmmod test_klp_callbacks_mod
[  112.061910] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  112.061925] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  112.061927] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  112.061928] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  112.137104] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  112.137122] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  112.137143] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  112.137144] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  112.137146] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  113.027375] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  113.029229] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  113.029230] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  113.029232] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  113.046037] % rmmod test_klp_callbacks_demo
[  113.117945] % rmmod test_klp_callbacks_busy
[  113.119077] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  113.184611] ===== TEST: busy target module =====
[  113.187764] % modprobe test_klp_callbacks_busy block_transition=Y
[  113.189352] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  113.189356] test_klp_callbacks_busy: busymod_work_func enter
[  113.192845] % modprobe test_klp_callbacks_demo
[  113.194361] livepatch: enabling patch 'test_klp_callbacks_demo'
[  113.194363] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  113.194384] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  113.194385] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  113.195818] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  113.201297] % modprobe test_klp_callbacks_mod
[  113.202625] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  113.202627] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  113.202719] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  113.203890] % rmmod test_klp_callbacks_mod
[  113.204951] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  113.204963] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  113.204964] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  113.267080] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  113.267098] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  113.267246] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  115.907346] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  115.909130] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  115.909132] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  115.909133] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  115.989675] % rmmod test_klp_callbacks_demo
[  116.047878] % rmmod test_klp_callbacks_busy
[  116.066667] test_klp_callbacks_busy: busymod_work_func exit
[  116.066674] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  116.194426] ===== TEST: multiple livepatches =====
[  116.197597] % modprobe test_klp_callbacks_demo
[  116.199116] livepatch: enabling patch 'test_klp_callbacks_demo'
[  116.199118] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  116.199139] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  116.199140] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  117.667375] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  117.667525] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  117.667527] livepatch: 'test_klp_callbacks_demo': patching complete
[  117.729276] % modprobe test_klp_callbacks_demo2
[  117.731386] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  117.731388] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  117.731409] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  117.731410] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  118.707443] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  118.707552] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  118.707553] livepatch: 'test_klp_callbacks_demo2': patching complete
[  118.749944] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  118.749964] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  118.749986] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  118.749987] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  119.907371] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  119.907541] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  119.907543] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  119.960612] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  119.960630] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  119.960649] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  119.960650] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  120.867332] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  120.867435] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  120.867436] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  120.869780] % rmmod test_klp_callbacks_demo2
[  120.917849] % rmmod test_klp_callbacks_demo
[  120.984589] ===== TEST: atomic replace =====
[  120.987657] % modprobe test_klp_callbacks_demo
[  120.989209] livepatch: enabling patch 'test_klp_callbacks_demo'
[  120.989211] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  120.989232] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  120.989233] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  121.907296] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  121.907399] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  121.907401] livepatch: 'test_klp_callbacks_demo': patching complete
[  122.010261] % modprobe test_klp_callbacks_demo2 replace=1
[  122.011745] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  122.011747] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  122.011767] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  122.011768] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  122.947337] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  122.947446] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  122.947448] livepatch: 'test_klp_callbacks_demo2': patching complete
[  123.030617] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  123.030637] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  123.030658] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  123.030659] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  123.907269] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  123.907424] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  123.907426] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  123.939784] % rmmod test_klp_callbacks_demo2
[  123.987825] % rmmod test_klp_callbacks_demo
[  124.090148] livepatch: kernel.ftrace_enabled = 1
[  124.097727] ===== TEST: basic shadow variable API =====
[  124.101462] % modprobe test_klp_shadow_vars
[  124.103146] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  124.103148] test_klp_shadow_vars:   got expected NULL result
[  124.103150] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  124.103151] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  124.103155] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  124.103156] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  124.103158] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  124.103160] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  124.103162] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  124.103163] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  124.103165] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  124.103167] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  124.103169] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  124.103170] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  124.103173] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  124.103174] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  124.103175] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  124.103176] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  124.103177] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  124.103179] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  124.103180] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  124.103181] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  124.103182] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  124.103184] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  124.103185] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  124.103186] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  124.103187] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  124.103189] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  124.103191] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  124.103193] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  124.103194] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  124.103196] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  124.103197] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  124.103199] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  124.103200] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  124.103201] test_klp_shadow_vars:   got expected NULL result
[  124.103202] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  124.103204] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  124.103205] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  124.103206] test_klp_shadow_vars:   got expected NULL result
[  124.103207] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  124.103208] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  124.103209] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  124.103211] test_klp_shadow_vars:   got expected NULL result
[  124.103212] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  124.103213] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  124.103214] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  124.103215] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  124.103216] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  124.103218] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  124.103231] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  124.103232] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  124.103233] test_klp_shadow_vars:   got expected NULL result
[  124.103234] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  124.103235] test_klp_shadow_vars:   got expected NULL result
[  124.103236] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  124.103238] test_klp_shadow_vars:   got expected NULL result
[  124.104546] % rmmod test_klp_shadow_vars
[  124.201338] livepatch: kernel.ftrace_enabled = 1
[  124.208997] ===== TEST: system state modification =====
[  124.212733] % modprobe test_klp_state
[  124.214788] livepatch: enabling patch 'test_klp_state'
[  124.214790] livepatch: 'test_klp_state': initializing patching transition
[  124.214811] test_klp_state: pre_patch_callback: vmlinux
[  124.214812] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  124.214814] livepatch: 'test_klp_state': starting patching transition
[  125.107324] livepatch: 'test_klp_state': completing patching transition
[  125.107502] test_klp_state: post_patch_callback: vmlinux
[  125.107504] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  125.107505] livepatch: 'test_klp_state': patching complete
[  125.132083] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  125.132120] livepatch: 'test_klp_state': initializing unpatching transition
[  125.132141] test_klp_state: pre_unpatch_callback: vmlinux
[  125.132142] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  125.132143] livepatch: 'test_klp_state': starting unpatching transition
[  125.987299] livepatch: 'test_klp_state': completing unpatching transition
[  125.987400] test_klp_state: post_unpatch_callback: vmlinux
[  125.987401] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  125.987402] livepatch: 'test_klp_state': unpatching complete
[  126.040767] % rmmod test_klp_state
[  126.104509] ===== TEST: taking over system state modification =====
[  126.107689] % modprobe test_klp_state
[  126.109150] livepatch: enabling patch 'test_klp_state'
[  126.109152] livepatch: 'test_klp_state': initializing patching transition
[  126.109173] test_klp_state: pre_patch_callback: vmlinux
[  126.109174] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  126.109176] livepatch: 'test_klp_state': starting patching transition
[  127.107325] livepatch: 'test_klp_state': completing patching transition
[  127.107431] test_klp_state: post_patch_callback: vmlinux
[  127.107432] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  127.107433] livepatch: 'test_klp_state': patching complete
[  127.131647] % modprobe test_klp_state2
[  127.133754] livepatch: enabling patch 'test_klp_state2'
[  127.133756] livepatch: 'test_klp_state2': initializing patching transition
[  127.133777] test_klp_state2: pre_patch_callback: vmlinux
[  127.133778] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  127.133779] livepatch: 'test_klp_state2': starting patching transition
[  127.987333] livepatch: 'test_klp_state2': completing patching transition
[  127.987456] test_klp_state2: post_patch_callback: vmlinux
[  127.987457] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  127.987458] livepatch: 'test_klp_state2': patching complete
[  128.051214] % rmmod test_klp_state
[  128.117089] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  128.117108] livepatch: 'test_klp_state2': initializing unpatching transition
[  128.117128] test_klp_state2: pre_unpatch_callback: vmlinux
[  128.117129] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  128.117131] livepatch: 'test_klp_state2': starting unpatching transition
[  129.027341] livepatch: 'test_klp_state2': completing unpatching transition
[  129.027447] test_klp_state2: post_unpatch_callback: vmlinux
[  129.027449] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  129.027451] livepatch: 'test_klp_state2': unpatching complete
[  129.127118] % rmmod test_klp_state2
[  129.194469] ===== TEST: compatible cumulative livepatches =====
[  129.197663] % modprobe test_klp_state2
[  129.199144] livepatch: enabling patch 'test_klp_state2'
[  129.199146] livepatch: 'test_klp_state2': initializing patching transition
[  129.199166] test_klp_state2: pre_patch_callback: vmlinux
[  129.199167] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  129.199168] livepatch: 'test_klp_state2': starting patching transition
[  130.707290] livepatch: 'test_klp_state2': completing patching transition
[  130.707484] test_klp_state2: post_patch_callback: vmlinux
[  130.707485] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  130.707486] livepatch: 'test_klp_state2': patching complete
[  130.728829] % modprobe test_klp_state3
[  130.730860] livepatch: enabling patch 'test_klp_state3'
[  130.730863] livepatch: 'test_klp_state3': initializing patching transition
[  130.730883] test_klp_state3: pre_patch_callback: vmlinux
[  130.730884] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  130.730886] livepatch: 'test_klp_state3': starting patching transition
[  131.747404] livepatch: 'test_klp_state3': completing patching transition
[  131.747514] test_klp_state3: post_patch_callback: vmlinux
[  131.747516] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  131.747517] livepatch: 'test_klp_state3': patching complete
[  131.751280] % rmmod test_klp_state2
[  131.830254] % modprobe test_klp_state2
[  131.831912] livepatch: enabling patch 'test_klp_state2'
[  131.831914] livepatch: 'test_klp_state2': initializing patching transition
[  131.831932] test_klp_state2: pre_patch_callback: vmlinux
[  131.831933] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  131.831934] livepatch: 'test_klp_state2': starting patching transition
[  132.787297] livepatch: 'test_klp_state2': completing patching transition
[  132.787417] test_klp_state2: post_patch_callback: vmlinux
[  132.787418] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  132.787420] livepatch: 'test_klp_state2': patching complete
[  132.849950] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  132.850015] livepatch: 'test_klp_state2': initializing unpatching transition
[  132.850036] test_klp_state2: pre_unpatch_callback: vmlinux
[  132.850037] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  132.850038] livepatch: 'test_klp_state2': starting unpatching transition
[  133.907269] livepatch: 'test_klp_state2': completing unpatching transition
[  133.907403] test_klp_state2: post_unpatch_callback: vmlinux
[  133.907405] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  133.907406] livepatch: 'test_klp_state2': unpatching complete
[  133.960649] % rmmod test_klp_state2
[  134.007856] % rmmod test_klp_state3
[  134.074550] ===== TEST: incompatible cumulative livepatches =====
[  134.077882] % modprobe test_klp_state2
[  134.079476] livepatch: enabling patch 'test_klp_state2'
[  134.079478] livepatch: 'test_klp_state2': initializing patching transition
[  134.079498] test_klp_state2: pre_patch_callback: vmlinux
[  134.079499] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  134.079501] livepatch: 'test_klp_state2': starting patching transition
[  135.587306] livepatch: 'test_klp_state2': completing patching transition
[  135.587415] test_klp_state2: post_patch_callback: vmlinux
[  135.587417] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  135.587418] livepatch: 'test_klp_state2': patching complete
[  135.606549] % modprobe test_klp_state
[  135.608261] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  135.736937] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  135.736975] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  135.736992] livepatch: 'test_klp_state2': initializing unpatching transition
[  135.737013] test_klp_state2: pre_unpatch_callback: vmlinux
[  135.737014] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  135.737015] livepatch: 'test_klp_state2': starting unpatching transition
[  136.947325] livepatch: 'test_klp_state2': completing unpatching transition
[  136.947481] test_klp_state2: post_unpatch_callback: vmlinux
[  136.947482] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  136.947483] livepatch: 'test_klp_state2': unpatching complete
[  136.948539] % rmmod test_klp_state2
[  137.041414] livepatch: kernel.ftrace_enabled = 1
[  137.049296] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  137.051220] livepatch: kernel.ftrace_enabled = 0
[  137.051281] % modprobe test_klp_livepatch
[  137.052860] livepatch: enabling patch 'test_klp_livepatch'
[  137.052862] livepatch: 'test_klp_livepatch': initializing patching transition
[  137.052885] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  137.052887] livepatch: failed to patch object 'vmlinux'
[  137.052888] livepatch: failed to enable patch 'test_klp_livepatch'
[  137.052889] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  137.052890] livepatch: 'test_klp_livepatch': completing unpatching transition
[  137.052996] livepatch: 'test_klp_livepatch': unpatching complete
[  137.176943] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  137.178976] livepatch: kernel.ftrace_enabled = 1
[  137.182231] % modprobe test_klp_livepatch
[  137.183760] livepatch: enabling patch 'test_klp_livepatch'
[  137.183762] livepatch: 'test_klp_livepatch': initializing patching transition
[  137.184843] livepatch: 'test_klp_livepatch': starting patching transition
[  138.067403] livepatch: 'test_klp_livepatch': completing patching transition
[  138.067507] livepatch: 'test_klp_livepatch': patching complete
[  138.105610] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  138.106627] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  138.106648] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  138.106672] livepatch: 'test_klp_livepatch': starting unpatching transition
[  139.107365] livepatch: 'test_klp_livepatch': completing unpatching transition
[  139.108879] livepatch: 'test_klp_livepatch': unpatching complete
[  139.116355] % rmmod test_klp_livepatch
[  139.200586] livepatch: kernel.ftrace_enabled = 1
[  139.208530] ===== TEST: sysfs test =====
[  139.211756] % modprobe test_klp_livepatch
[  139.213178] livepatch: enabling patch 'test_klp_livepatch'
[  139.213180] livepatch: 'test_klp_livepatch': initializing patching transition
[  139.214331] livepatch: 'test_klp_livepatch': starting patching transition
[  140.867306] livepatch: 'test_klp_livepatch': completing patching transition
[  140.867409] livepatch: 'test_klp_livepatch': patching complete
[  140.953991] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  140.954006] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  140.954028] livepatch: 'test_klp_livepatch': starting unpatching transition
[  141.997333] livepatch: 'test_klp_livepatch': completing unpatching transition
[  141.998940] livepatch: 'test_klp_livepatch': unpatching complete
[  142.064873] % rmmod test_klp_livepatch
[  142.144542] ===== TEST: sysfs test object/patched =====
[  142.147844] % modprobe test_klp_callbacks_demo
[  142.149314] livepatch: enabling patch 'test_klp_callbacks_demo'
[  142.149316] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  142.149336] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  142.149337] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  143.027295] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  143.027399] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  143.027400] livepatch: 'test_klp_callbacks_demo': patching complete
[  143.071068] % modprobe test_klp_callbacks_mod
[  143.072452] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  143.072454] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.072456] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.072497] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  143.074775] % rmmod test_klp_callbacks_mod
[  143.076064] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  143.076077] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.076079] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  143.076081] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.137979] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  143.138015] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  143.138036] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  143.138038] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  144.147343] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  144.147528] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  144.147530] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  144.249115] % rmmod test_klp_callbacks_demo
[  149.652836] livepatch: kernel.ftrace_enabled = 1
[  149.660651] ===== TEST: basic function patching =====
[  149.663714] % modprobe test_klp_livepatch
[  149.665324] livepatch: enabling patch 'test_klp_livepatch'
[  149.665326] livepatch: 'test_klp_livepatch': initializing patching transition
[  149.666432] livepatch: 'test_klp_livepatch': starting patching transition
[  151.027254] livepatch: 'test_klp_livepatch': completing patching transition
[  151.027390] livepatch: 'test_klp_livepatch': patching complete
[  151.092898] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  151.092917] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  151.092934] livepatch: 'test_klp_livepatch': starting unpatching transition
[  152.067265] livepatch: 'test_klp_livepatch': completing unpatching transition
[  152.068794] livepatch: 'test_klp_livepatch': unpatching complete
[  152.102901] % rmmod test_klp_livepatch
[  152.175346] ===== TEST: multiple livepatches =====
[  152.178402] % modprobe test_klp_livepatch
[  152.179854] livepatch: enabling patch 'test_klp_livepatch'
[  152.179857] livepatch: 'test_klp_livepatch': initializing patching transition
[  152.181052] livepatch: 'test_klp_livepatch': starting patching transition
[  153.587227] livepatch: 'test_klp_livepatch': completing patching transition
[  153.587346] livepatch: 'test_klp_livepatch': patching complete
[  153.605914] test_klp_livepatch: this has been live patched
[  153.610106] % modprobe test_klp_atomic_replace replace=0
[  153.611743] livepatch: enabling patch 'test_klp_atomic_replace'
[  153.611746] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  153.612988] livepatch: 'test_klp_atomic_replace': starting patching transition
[  154.867269] livepatch: 'test_klp_atomic_replace': completing patching transition
[  154.867427] livepatch: 'test_klp_atomic_replace': patching complete
[  154.936390] test_klp_livepatch: this has been live patched
[  154.937249] test_klp_atomic_replace: this has been live patched
[  154.937424] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  154.937443] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  154.937463] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  156.067196] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  156.068608] livepatch: 'test_klp_atomic_replace': unpatching complete
[  156.148189] % rmmod test_klp_atomic_replace
[  156.197593] test_klp_livepatch: this has been live patched
[  156.198534] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  156.198551] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  156.198569] livepatch: 'test_klp_livepatch': starting unpatching transition
[  157.027245] livepatch: 'test_klp_livepatch': completing unpatching transition
[  157.028678] livepatch: 'test_klp_livepatch': unpatching complete
[  157.107307] % rmmod test_klp_livepatch
[  157.196290] ===== TEST: atomic replace livepatch =====
[  157.199586] % modprobe test_klp_livepatch
[  157.201016] livepatch: enabling patch 'test_klp_livepatch'
[  157.201018] livepatch: 'test_klp_livepatch': initializing patching transition
[  157.202113] livepatch: 'test_klp_livepatch': starting patching transition
[  159.027189] livepatch: 'test_klp_livepatch': completing patching transition
[  159.027295] livepatch: 'test_klp_livepatch': patching complete
[  159.033053] test_klp_livepatch: this has been live patched
[  159.037594] % modprobe test_klp_atomic_replace replace=1
[  159.039272] livepatch: enabling patch 'test_klp_atomic_replace'
[  159.039274] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  159.040394] livepatch: 'test_klp_atomic_replace': starting patching transition
[  160.627247] livepatch: 'test_klp_atomic_replace': completing patching transition
[  160.628733] livepatch: 'test_klp_atomic_replace': patching complete
[  160.669276] test_klp_atomic_replace: this has been live patched
[  160.670250] % rmmod test_klp_livepatch
[  160.728472] test_klp_atomic_replace: this has been live patched
[  160.728578] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  160.728647] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  160.728675] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  162.067222] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  162.068711] livepatch: 'test_klp_atomic_replace': unpatching complete
[  162.140945] % rmmod test_klp_atomic_replace
[  162.231887] livepatch: kernel.ftrace_enabled = 1
[  162.239588] ===== TEST: target module before livepatch =====
[  162.242938] % modprobe test_klp_callbacks_mod
[  162.244287] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  162.247833] % modprobe test_klp_callbacks_demo
[  162.249367] livepatch: enabling patch 'test_klp_callbacks_demo'
[  162.249369] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  162.249388] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  162.249389] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  162.249406] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  163.747295] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  163.747452] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  163.747454] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  163.747456] livepatch: 'test_klp_callbacks_demo': patching complete
[  163.776543] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  163.776563] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  163.776586] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  163.776587] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  163.776589] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  165.027266] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  165.027372] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  165.027374] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  165.027375] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  165.088636] % rmmod test_klp_callbacks_demo
[  165.147720] % rmmod test_klp_callbacks_mod
[  165.148920] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  165.243998] ===== TEST: module_coming notifier =====
[  165.247169] % modprobe test_klp_callbacks_demo
[  165.248711] livepatch: enabling patch 'test_klp_callbacks_demo'
[  165.248713] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  165.248734] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  165.248735] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  166.707205] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  166.707378] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  166.707380] livepatch: 'test_klp_callbacks_demo': patching complete
[  166.778763] % modprobe test_klp_callbacks_mod
[  166.780198] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  166.780201] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  166.780203] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  166.780245] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  166.780610] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  166.780628] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  166.780649] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  166.780650] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  166.780652] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  168.067171] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  168.067288] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  168.067289] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  168.067291] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  168.092769] % rmmod test_klp_callbacks_demo
[  168.137636] % rmmod test_klp_callbacks_mod
[  168.138733] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  168.214554] ===== TEST: module_going notifier =====
[  168.217657] % modprobe test_klp_callbacks_mod
[  168.219088] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  168.222668] % modprobe test_klp_callbacks_demo
[  168.224189] livepatch: enabling patch 'test_klp_callbacks_demo'
[  168.224190] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  168.224209] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  168.224210] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  168.224211] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  169.027192] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  169.027294] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  169.027296] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  169.027297] livepatch: 'test_klp_callbacks_demo': patching complete
[  169.039955] % rmmod test_klp_callbacks_mod
[  169.041211] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  169.041225] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  169.041227] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  169.041229] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  169.096825] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  169.096842] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  169.096860] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  169.096861] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  170.067135] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  170.067237] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  170.067239] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  170.106247] % rmmod test_klp_callbacks_demo
[  170.184203] ===== TEST: module_coming and module_going notifiers =====
[  170.187291] % modprobe test_klp_callbacks_demo
[  170.188838] livepatch: enabling patch 'test_klp_callbacks_demo'
[  170.188840] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  170.188861] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  170.188862] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  171.837198] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  171.837326] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  171.837328] livepatch: 'test_klp_callbacks_demo': patching complete
[  171.921732] % modprobe test_klp_callbacks_mod
[  171.923091] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  171.923094] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  171.923096] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  171.923138] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  171.924441] % rmmod test_klp_callbacks_mod
[  171.925535] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  171.925548] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  171.925550] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  171.925551] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  171.966871] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  171.966889] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  171.966909] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  171.966910] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  173.027199] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  173.027354] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  173.027355] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  173.076841] % rmmod test_klp_callbacks_demo
[  173.144067] ===== TEST: target module not present =====
[  173.147097] % modprobe test_klp_callbacks_demo
[  173.148676] livepatch: enabling patch 'test_klp_callbacks_demo'
[  173.148678] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  173.148717] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  173.148719] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  174.627151] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  174.627256] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  174.627257] livepatch: 'test_klp_callbacks_demo': patching complete
[  174.675094] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  174.675112] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  174.675133] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  174.675134] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  176.067150] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  176.067252] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  176.067253] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  176.088083] % rmmod test_klp_callbacks_demo
[  176.194636] ===== TEST: pre-patch callback -ENODEV =====
[  176.197807] % modprobe test_klp_callbacks_mod
[  176.199160] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  176.199520] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  176.201031] livepatch: enabling patch 'test_klp_callbacks_demo'
[  176.201033] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  176.201061] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  176.201062] livepatch: pre-patch callback failed for object 'vmlinux'
[  176.201063] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  176.201064] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  176.201079] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  176.201187] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  176.346872] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  176.347900] % rmmod test_klp_callbacks_mod
[  176.349044] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  176.424402] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  176.427567] % modprobe test_klp_callbacks_demo
[  176.429103] livepatch: enabling patch 'test_klp_callbacks_demo'
[  176.429105] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  176.429125] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  176.429126] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  177.667156] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  177.667260] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  177.667261] livepatch: 'test_klp_callbacks_demo': patching complete
[  177.753119] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  177.754056] % modprobe test_klp_callbacks_mod
[  177.755378] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  177.755381] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  177.755383] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  177.755385] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  177.846782] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  177.846853] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  177.846869] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  177.846891] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  177.846892] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  179.027108] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  179.027212] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  179.027214] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  179.058400] % rmmod test_klp_callbacks_demo
[  179.124598] ===== TEST: multiple target modules =====
[  179.127765] % modprobe test_klp_callbacks_busy block_transition=N
[  179.129305] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  179.129311] test_klp_callbacks_busy: busymod_work_func enter
[  179.129313] test_klp_callbacks_busy: busymod_work_func exit
[  179.132729] % modprobe test_klp_callbacks_demo
[  179.134243] livepatch: enabling patch 'test_klp_callbacks_demo'
[  179.134247] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  179.134267] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  179.134268] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  179.135680] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  180.947100] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  180.947201] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  180.947203] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  180.947204] livepatch: 'test_klp_callbacks_demo': patching complete
[  180.970719] % modprobe test_klp_callbacks_mod
[  180.972226] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  180.972228] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  180.972230] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  180.972273] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  180.973615] % rmmod test_klp_callbacks_mod
[  180.974736] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  180.974748] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  180.974750] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  180.974751] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  181.046824] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  181.046842] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  181.046860] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  181.046861] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  181.046863] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  181.907102] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  181.908849] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  181.908851] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  181.908853] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  181.955928] % rmmod test_klp_callbacks_demo
[  182.057660] % rmmod test_klp_callbacks_busy
[  182.058777] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  182.134704] ===== TEST: busy target module =====
[  182.137780] % modprobe test_klp_callbacks_busy block_transition=Y
[  182.139259] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  182.139263] test_klp_callbacks_busy: busymod_work_func enter
[  182.142889] % modprobe test_klp_callbacks_demo
[  182.144362] livepatch: enabling patch 'test_klp_callbacks_demo'
[  182.144364] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  182.144382] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  182.144383] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  182.145742] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  182.150873] % modprobe test_klp_callbacks_mod
[  182.152293] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  182.152296] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  182.152339] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  182.153479] % rmmod test_klp_callbacks_mod
[  182.154578] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  182.154591] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  182.154592] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  182.196952] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  182.196973] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  182.197122] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  184.947083] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  184.948859] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  184.948861] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  184.948862] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  185.020008] % rmmod test_klp_callbacks_demo
[  185.077670] % rmmod test_klp_callbacks_busy
[  185.106398] test_klp_callbacks_busy: busymod_work_func exit
[  185.106407] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  185.184323] ===== TEST: multiple livepatches =====
[  185.187426] % modprobe test_klp_callbacks_demo
[  185.188999] livepatch: enabling patch 'test_klp_callbacks_demo'
[  185.189001] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  185.189021] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  185.189022] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  186.067143] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  186.067283] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  186.067284] livepatch: 'test_klp_callbacks_demo': patching complete
[  186.109240] % modprobe test_klp_callbacks_demo2
[  186.110881] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  186.110883] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  186.110904] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  186.110906] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  187.107240] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  187.107352] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  187.107353] livepatch: 'test_klp_callbacks_demo2': patching complete
[  187.129168] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  187.129188] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  187.129208] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  187.129209] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  187.987516] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  187.987618] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  187.987620] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  188.037170] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  188.037188] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  188.037205] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  188.037206] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  189.027062] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  189.027164] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  189.027166] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  189.047265] % rmmod test_klp_callbacks_demo2
[  189.137664] % rmmod test_klp_callbacks_demo
[  189.224455] ===== TEST: atomic replace =====
[  189.227586] % modprobe test_klp_callbacks_demo
[  189.229201] livepatch: enabling patch 'test_klp_callbacks_demo'
[  189.229203] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  189.229222] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  189.229224] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  190.067084] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  190.067235] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  190.067237] livepatch: 'test_klp_callbacks_demo': patching complete
[  190.148887] % modprobe test_klp_callbacks_demo2 replace=1
[  190.150416] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  190.150419] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  190.150439] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  190.150441] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  191.747107] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  191.747218] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  191.747220] livepatch: 'test_klp_callbacks_demo2': patching complete
[  191.778578] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  191.778598] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  191.778619] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  191.778621] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  192.947121] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  192.947227] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  192.947229] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  192.989892] % rmmod test_klp_callbacks_demo2
[  193.057940] % rmmod test_klp_callbacks_demo
[  193.160197] livepatch: kernel.ftrace_enabled = 1
[  193.167730] ===== TEST: basic shadow variable API =====
[  193.170833] % modprobe test_klp_shadow_vars
[  193.172209] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  193.172211] test_klp_shadow_vars:   got expected NULL result
[  193.172213] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  193.172214] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  193.172217] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  193.172218] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  193.172220] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  193.172221] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  193.172224] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  193.172225] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  193.172227] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  193.172229] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  193.172231] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  193.172232] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  193.172234] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  193.172236] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  193.172237] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  193.172238] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  193.172239] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  193.172240] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  193.172241] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  193.172243] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  193.172244] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  193.172245] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  193.172246] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  193.172247] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  193.172249] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  193.172251] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  193.172252] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  193.172254] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  193.172255] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  193.172257] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  193.172258] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  193.172260] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  193.172261] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  193.172262] test_klp_shadow_vars:   got expected NULL result
[  193.172263] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  193.172265] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  193.172266] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  193.172267] test_klp_shadow_vars:   got expected NULL result
[  193.172268] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  193.172269] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  193.172270] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  193.172271] test_klp_shadow_vars:   got expected NULL result
[  193.172272] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  193.172274] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  193.172275] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  193.172276] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  193.172277] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  193.172278] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  193.172287] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  193.172288] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  193.172289] test_klp_shadow_vars:   got expected NULL result
[  193.172290] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  193.172291] test_klp_shadow_vars:   got expected NULL result
[  193.172292] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  193.172293] test_klp_shadow_vars:   got expected NULL result
[  193.173588] % rmmod test_klp_shadow_vars
[  193.270211] livepatch: kernel.ftrace_enabled = 1
[  193.277772] ===== TEST: system state modification =====
[  193.280982] % modprobe test_klp_state
[  193.282421] livepatch: enabling patch 'test_klp_state'
[  193.282422] livepatch: 'test_klp_state': initializing patching transition
[  193.282443] test_klp_state: pre_patch_callback: vmlinux
[  193.282444] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  193.282445] livepatch: 'test_klp_state': starting patching transition
[  194.627016] livepatch: 'test_klp_state': completing patching transition
[  194.627121] test_klp_state: post_patch_callback: vmlinux
[  194.627122] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  194.627123] livepatch: 'test_klp_state': patching complete
[  194.707923] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  194.707943] livepatch: 'test_klp_state': initializing unpatching transition
[  194.707962] test_klp_state: pre_unpatch_callback: vmlinux
[  194.707963] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  194.707964] livepatch: 'test_klp_state': starting unpatching transition
[  195.667037] livepatch: 'test_klp_state': completing unpatching transition
[  195.667141] test_klp_state: post_unpatch_callback: vmlinux
[  195.667143] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  195.667144] livepatch: 'test_klp_state': unpatching complete
[  195.718014] % rmmod test_klp_state
[  195.794830] ===== TEST: taking over system state modification =====
[  195.797971] % modprobe test_klp_state
[  195.799572] livepatch: enabling patch 'test_klp_state'
[  195.799574] livepatch: 'test_klp_state': initializing patching transition
[  195.799595] test_klp_state: pre_patch_callback: vmlinux
[  195.799596] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  195.799598] livepatch: 'test_klp_state': starting patching transition
[  196.867056] livepatch: 'test_klp_state': completing patching transition
[  196.867162] test_klp_state: post_patch_callback: vmlinux
[  196.867164] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  196.867165] livepatch: 'test_klp_state': patching complete
[  196.922499] % modprobe test_klp_state2
[  196.924010] livepatch: enabling patch 'test_klp_state2'
[  196.924012] livepatch: 'test_klp_state2': initializing patching transition
[  196.924032] test_klp_state2: pre_patch_callback: vmlinux
[  196.924033] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  196.924034] livepatch: 'test_klp_state2': starting patching transition
[  198.627070] livepatch: 'test_klp_state2': completing patching transition
[  198.627227] test_klp_state2: post_patch_callback: vmlinux
[  198.627229] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  198.627230] livepatch: 'test_klp_state2': patching complete
[  198.654169] % rmmod test_klp_state
[  198.696775] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  198.696796] livepatch: 'test_klp_state2': initializing unpatching transition
[  198.696818] test_klp_state2: pre_unpatch_callback: vmlinux
[  198.696820] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  198.696821] livepatch: 'test_klp_state2': starting unpatching transition
[  199.667041] livepatch: 'test_klp_state2': completing unpatching transition
[  199.667222] test_klp_state2: post_unpatch_callback: vmlinux
[  199.667223] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  199.667224] livepatch: 'test_klp_state2': unpatching complete
[  199.706641] % rmmod test_klp_state2
[  199.794709] ===== TEST: compatible cumulative livepatches =====
[  199.797951] % modprobe test_klp_state2
[  199.799497] livepatch: enabling patch 'test_klp_state2'
[  199.799500] livepatch: 'test_klp_state2': initializing patching transition
[  199.799521] test_klp_state2: pre_patch_callback: vmlinux
[  199.799522] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  199.799524] livepatch: 'test_klp_state2': starting patching transition
[  200.707033] livepatch: 'test_klp_state2': completing patching transition
[  200.707156] test_klp_state2: post_patch_callback: vmlinux
[  200.707158] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  200.707159] livepatch: 'test_klp_state2': patching complete
[  200.719453] % modprobe test_klp_state3
[  200.721036] livepatch: enabling patch 'test_klp_state3'
[  200.721040] livepatch: 'test_klp_state3': initializing patching transition
[  200.721063] test_klp_state3: pre_patch_callback: vmlinux
[  200.721064] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  200.721065] livepatch: 'test_klp_state3': starting patching transition
[  201.667030] livepatch: 'test_klp_state3': completing patching transition
[  201.667132] test_klp_state3: post_patch_callback: vmlinux
[  201.667134] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  201.667135] livepatch: 'test_klp_state3': patching complete
[  201.740654] % rmmod test_klp_state2
[  201.790108] % modprobe test_klp_state2
[  201.791613] livepatch: enabling patch 'test_klp_state2'
[  201.791616] livepatch: 'test_klp_state2': initializing patching transition
[  201.791636] test_klp_state2: pre_patch_callback: vmlinux
[  201.791637] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  201.791639] livepatch: 'test_klp_state2': starting patching transition
[  202.947001] livepatch: 'test_klp_state2': completing patching transition
[  202.947134] test_klp_state2: post_patch_callback: vmlinux
[  202.947136] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  202.947137] livepatch: 'test_klp_state2': patching complete
[  203.013457] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  203.013476] livepatch: 'test_klp_state2': initializing unpatching transition
[  203.013497] test_klp_state2: pre_unpatch_callback: vmlinux
[  203.013498] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  203.013499] livepatch: 'test_klp_state2': starting unpatching transition
[  204.627021] livepatch: 'test_klp_state2': completing unpatching transition
[  204.627127] test_klp_state2: post_unpatch_callback: vmlinux
[  204.627128] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  204.627130] livepatch: 'test_klp_state2': unpatching complete
[  204.628240] % rmmod test_klp_state2
[  204.677492] % rmmod test_klp_state3
[  204.754498] ===== TEST: incompatible cumulative livepatches =====
[  204.757803] % modprobe test_klp_state2
[  204.759469] livepatch: enabling patch 'test_klp_state2'
[  204.759471] livepatch: 'test_klp_state2': initializing patching transition
[  204.759509] test_klp_state2: pre_patch_callback: vmlinux
[  204.759511] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  204.759512] livepatch: 'test_klp_state2': starting patching transition
[  205.667054] livepatch: 'test_klp_state2': completing patching transition
[  205.667221] test_klp_state2: post_patch_callback: vmlinux
[  205.667223] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  205.667224] livepatch: 'test_klp_state2': patching complete
[  205.676418] % modprobe test_klp_state
[  205.678021] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  205.796666] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  205.796711] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  205.796727] livepatch: 'test_klp_state2': initializing unpatching transition
[  205.796748] test_klp_state2: pre_unpatch_callback: vmlinux
[  205.796749] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  205.796750] livepatch: 'test_klp_state2': starting unpatching transition
[  206.627024] livepatch: 'test_klp_state2': completing unpatching transition
[  206.627126] test_klp_state2: post_unpatch_callback: vmlinux
[  206.627127] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  206.627128] livepatch: 'test_klp_state2': unpatching complete
[  206.705649] % rmmod test_klp_state2
[  206.799832] livepatch: kernel.ftrace_enabled = 1
[  206.807523] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  206.809453] livepatch: kernel.ftrace_enabled = 0
[  206.809519] % modprobe test_klp_livepatch
[  206.811132] livepatch: enabling patch 'test_klp_livepatch'
[  206.811134] livepatch: 'test_klp_livepatch': initializing patching transition
[  206.811157] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  206.811159] livepatch: failed to patch object 'vmlinux'
[  206.811160] livepatch: failed to enable patch 'test_klp_livepatch'
[  206.811161] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  206.811162] livepatch: 'test_klp_livepatch': completing unpatching transition
[  206.811267] livepatch: 'test_klp_livepatch': unpatching complete
[  206.946752] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  206.948665] livepatch: kernel.ftrace_enabled = 1
[  206.951864] % modprobe test_klp_livepatch
[  206.953500] livepatch: enabling patch 'test_klp_livepatch'
[  206.953502] livepatch: 'test_klp_livepatch': initializing patching transition
[  206.954621] livepatch: 'test_klp_livepatch': starting patching transition
[  208.147074] livepatch: 'test_klp_livepatch': completing patching transition
[  208.147180] livepatch: 'test_klp_livepatch': patching complete
[  208.181130] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  208.182202] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  208.182223] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  208.182241] livepatch: 'test_klp_livepatch': starting unpatching transition
[  209.106989] livepatch: 'test_klp_livepatch': completing unpatching transition
[  209.108516] livepatch: 'test_klp_livepatch': unpatching complete
[  209.192468] % rmmod test_klp_livepatch
[  209.269412] livepatch: kernel.ftrace_enabled = 1
[  209.277289] ===== TEST: sysfs test =====
[  209.280562] % modprobe test_klp_livepatch
[  209.282041] livepatch: enabling patch 'test_klp_livepatch'
[  209.282043] livepatch: 'test_klp_livepatch': initializing patching transition
[  209.283130] livepatch: 'test_klp_livepatch': starting patching transition
[  210.946994] livepatch: 'test_klp_livepatch': completing patching transition
[  210.947096] livepatch: 'test_klp_livepatch': patching complete
[  211.020069] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  211.020084] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  211.020103] livepatch: 'test_klp_livepatch': starting unpatching transition
[  211.906955] livepatch: 'test_klp_livepatch': completing unpatching transition
[  211.908429] livepatch: 'test_klp_livepatch': unpatching complete
[  211.928959] % rmmod test_klp_livepatch
[  212.004690] ===== TEST: sysfs test object/patched =====
[  212.007954] % modprobe test_klp_callbacks_demo
[  212.009626] livepatch: enabling patch 'test_klp_callbacks_demo'
[  212.009628] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  212.009649] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  212.009650] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  213.106985] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  213.107148] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  213.107150] livepatch: 'test_klp_callbacks_demo': patching complete
[  213.133983] % modprobe test_klp_callbacks_mod
[  213.135432] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  213.135434] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  213.135436] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  213.135478] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  213.137671] % rmmod test_klp_callbacks_mod
[  213.138782] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  213.138796] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  213.138798] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  213.138799] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  213.187620] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  213.187639] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  213.187660] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  213.187661] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  214.956966] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  214.957069] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  214.957070] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  215.004034] % rmmod test_klp_callbacks_demo
[  216.486413] livepatch: kernel.ftrace_enabled = 1
[  216.494184] ===== TEST: basic function patching =====
[  216.497478] % modprobe test_klp_livepatch
[  216.499123] livepatch: enabling patch 'test_klp_livepatch'
[  216.499125] livepatch: 'test_klp_livepatch': initializing patching transition
[  216.500232] livepatch: 'test_klp_livepatch': starting patching transition
[  217.906980] livepatch: 'test_klp_livepatch': completing patching transition
[  217.907138] livepatch: 'test_klp_livepatch': patching complete
[  217.927548] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  217.927569] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  217.927590] livepatch: 'test_klp_livepatch': starting unpatching transition
[  218.947043] livepatch: 'test_klp_livepatch': completing unpatching transition
[  218.948644] livepatch: 'test_klp_livepatch': unpatching complete
[  219.038726] % rmmod test_klp_livepatch
[  219.115033] ===== TEST: multiple livepatches =====
[  219.118186] % modprobe test_klp_livepatch
[  219.119788] livepatch: enabling patch 'test_klp_livepatch'
[  219.119790] livepatch: 'test_klp_livepatch': initializing patching transition
[  219.120986] livepatch: 'test_klp_livepatch': starting patching transition
[  220.866989] livepatch: 'test_klp_livepatch': completing patching transition
[  220.867145] livepatch: 'test_klp_livepatch': patching complete
[  220.952783] test_klp_livepatch: this has been live patched
[  220.957044] % modprobe test_klp_atomic_replace replace=0
[  220.958580] livepatch: enabling patch 'test_klp_atomic_replace'
[  220.958582] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  220.959660] livepatch: 'test_klp_atomic_replace': starting patching transition
[  221.826984] livepatch: 'test_klp_atomic_replace': completing patching transition
[  221.827087] livepatch: 'test_klp_atomic_replace': patching complete
[  221.877823] test_klp_livepatch: this has been live patched
[  221.878665] test_klp_atomic_replace: this has been live patched
[  221.878801] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  221.878822] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  221.878843] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  222.947011] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  222.948465] livepatch: 'test_klp_atomic_replace': unpatching complete
[  222.989788] % rmmod test_klp_atomic_replace
[  223.047531] test_klp_livepatch: this has been live patched
[  223.048613] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  223.048632] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  223.048654] livepatch: 'test_klp_livepatch': starting unpatching transition
[  223.987012] livepatch: 'test_klp_livepatch': completing unpatching transition
[  223.988534] livepatch: 'test_klp_livepatch': unpatching complete
[  224.059000] % rmmod test_klp_livepatch
[  224.156318] ===== TEST: atomic replace livepatch =====
[  224.159489] % modprobe test_klp_livepatch
[  224.160923] livepatch: enabling patch 'test_klp_livepatch'
[  224.160926] livepatch: 'test_klp_livepatch': initializing patching transition
[  224.162024] livepatch: 'test_klp_livepatch': starting patching transition
[  225.666965] livepatch: 'test_klp_livepatch': completing patching transition
[  225.667118] livepatch: 'test_klp_livepatch': patching complete
[  225.689716] test_klp_livepatch: this has been live patched
[  225.693937] % modprobe test_klp_atomic_replace replace=1
[  225.695517] livepatch: enabling patch 'test_klp_atomic_replace'
[  225.695519] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  225.696644] livepatch: 'test_klp_atomic_replace': starting patching transition
[  226.786967] livepatch: 'test_klp_atomic_replace': completing patching transition
[  226.788286] livepatch: 'test_klp_atomic_replace': patching complete
[  226.818010] test_klp_atomic_replace: this has been live patched
[  226.819031] % rmmod test_klp_livepatch
[  226.878235] test_klp_atomic_replace: this has been live patched
[  226.878402] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  226.878421] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  226.878443] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  227.907041] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  227.908601] livepatch: 'test_klp_atomic_replace': unpatching complete
[  227.988889] % rmmod test_klp_atomic_replace
[  228.081616] livepatch: kernel.ftrace_enabled = 1
[  228.089746] ===== TEST: target module before livepatch =====
[  228.093012] % modprobe test_klp_callbacks_mod
[  228.094389] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  228.097768] % modprobe test_klp_callbacks_demo
[  228.099261] livepatch: enabling patch 'test_klp_callbacks_demo'
[  228.099263] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  228.099286] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  228.099287] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  228.099289] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  229.027084] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  229.027196] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  229.027198] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  229.027199] livepatch: 'test_klp_callbacks_demo': patching complete
[  229.118464] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  229.118483] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  229.118504] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  229.118505] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  229.118506] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  230.866938] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  230.867117] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  230.867118] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  230.867120] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  230.935471] % rmmod test_klp_callbacks_demo
[  230.997625] % rmmod test_klp_callbacks_mod
[  230.998771] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  231.064190] ===== TEST: module_coming notifier =====
[  231.067155] % modprobe test_klp_callbacks_demo
[  231.068630] livepatch: enabling patch 'test_klp_callbacks_demo'
[  231.068632] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  231.068652] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  231.068653] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  232.786968] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  232.787122] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  232.787123] livepatch: 'test_klp_callbacks_demo': patching complete
[  232.800046] % modprobe test_klp_callbacks_mod
[  232.801418] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  232.801421] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  232.801423] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  232.801465] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  232.801808] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  232.801826] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  232.801848] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  232.801849] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  232.801850] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  233.906995] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  233.907137] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  233.907139] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  233.907140] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  233.912080] % rmmod test_klp_callbacks_demo
[  233.987482] % rmmod test_klp_callbacks_mod
[  233.988644] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  234.064216] ===== TEST: module_going notifier =====
[  234.067491] % modprobe test_klp_callbacks_mod
[  234.068784] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  234.072123] % modprobe test_klp_callbacks_demo
[  234.073590] livepatch: enabling patch 'test_klp_callbacks_demo'
[  234.073592] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  234.073611] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  234.073613] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  234.073614] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  234.866962] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  234.867066] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  234.867068] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  234.867069] livepatch: 'test_klp_callbacks_demo': patching complete
[  234.889218] % rmmod test_klp_callbacks_mod
[  234.890290] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  234.890303] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  234.890305] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  234.890307] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  234.936640] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  234.936658] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  234.936677] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  234.936678] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  235.906953] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  235.907059] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  235.907060] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  235.946374] % rmmod test_klp_callbacks_demo
[  236.044816] ===== TEST: module_coming and module_going notifiers =====
[  236.047961] % modprobe test_klp_callbacks_demo
[  236.049483] livepatch: enabling patch 'test_klp_callbacks_demo'
[  236.049485] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  236.049505] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  236.049506] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  236.947000] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  236.947176] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  236.947178] livepatch: 'test_klp_callbacks_demo': patching complete
[  236.969682] % modprobe test_klp_callbacks_mod
[  236.971078] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  236.971080] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  236.971082] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  236.971123] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  236.972339] % rmmod test_klp_callbacks_mod
[  236.973427] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  236.973439] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  236.973441] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  236.973442] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  237.036714] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  237.036732] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  237.036753] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  237.036754] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  237.906936] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  237.907087] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  237.907088] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  237.945408] % rmmod test_klp_callbacks_demo
[  238.024442] ===== TEST: target module not present =====
[  238.027541] % modprobe test_klp_callbacks_demo
[  238.028922] livepatch: enabling patch 'test_klp_callbacks_demo'
[  238.028925] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  238.028945] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  238.028946] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  239.666976] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  239.667083] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  239.667084] livepatch: 'test_klp_callbacks_demo': patching complete
[  239.757876] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  239.757896] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  239.757916] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  239.757917] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  240.866920] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  240.867056] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  240.867058] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  240.868130] % rmmod test_klp_callbacks_demo
[  240.960617] ERROR: livepatch kselftest(s) failed
[  241.022110] livepatch: kernel.ftrace_enabled = 1
[  241.029698] ===== TEST: basic shadow variable API =====
[  241.032978] % modprobe test_klp_shadow_vars
[  241.034446] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  241.034448] test_klp_shadow_vars:   got expected NULL result
[  241.034449] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  241.034451] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  241.034454] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  241.034455] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  241.034457] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  241.034459] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  241.034461] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  241.034462] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  241.034464] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  241.034466] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  241.034468] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  241.034469] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  241.034471] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  241.034473] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  241.034474] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  241.034475] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  241.034476] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  241.034478] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  241.034479] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  241.034480] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  241.034481] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  241.034482] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  241.034483] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  241.034485] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  241.034486] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  241.034488] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  241.034489] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  241.034491] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  241.034492] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  241.034494] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  241.034496] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  241.034497] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  241.034499] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  241.034500] test_klp_shadow_vars:   got expected NULL result
[  241.034501] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  241.034502] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  241.034503] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  241.034505] test_klp_shadow_vars:   got expected NULL result
[  241.034505] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  241.034507] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  241.034508] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  241.034509] test_klp_shadow_vars:   got expected NULL result
[  241.034510] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  241.034512] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  241.034513] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  241.034514] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  241.034515] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  241.034516] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  241.034522] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  241.034523] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  241.034524] test_klp_shadow_vars:   got expected NULL result
[  241.034525] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  241.034526] test_klp_shadow_vars:   got expected NULL result
[  241.034527] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  241.034528] test_klp_shadow_vars:   got expected NULL result
[  241.035837] % rmmod test_klp_shadow_vars
[  241.150238] livepatch: kernel.ftrace_enabled = 1
[  241.157791] ===== TEST: system state modification =====
[  241.161055] % modprobe test_klp_state
[  241.162597] livepatch: enabling patch 'test_klp_state'
[  241.162599] livepatch: 'test_klp_state': initializing patching transition
[  241.162624] test_klp_state: pre_patch_callback: vmlinux
[  241.162625] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  241.162626] livepatch: 'test_klp_state': starting patching transition
[  242.636994] livepatch: 'test_klp_state': completing patching transition
[  242.637119] test_klp_state: post_patch_callback: vmlinux
[  242.637121] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  242.637122] livepatch: 'test_klp_state': patching complete
[  242.690300] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  242.690318] livepatch: 'test_klp_state': initializing unpatching transition
[  242.690340] test_klp_state: pre_unpatch_callback: vmlinux
[  242.690341] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  242.690342] livepatch: 'test_klp_state': starting unpatching transition
[  243.666983] livepatch: 'test_klp_state': completing unpatching transition
[  243.667104] test_klp_state: post_unpatch_callback: vmlinux
[  243.667105] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  243.667106] livepatch: 'test_klp_state': unpatching complete
[  243.700880] % rmmod test_klp_state
[  243.774968] ===== TEST: taking over system state modification =====
[  243.778186] % modprobe test_klp_state
[  243.779642] livepatch: enabling patch 'test_klp_state'
[  243.779645] livepatch: 'test_klp_state': initializing patching transition
[  243.779665] test_klp_state: pre_patch_callback: vmlinux
[  243.779667] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  243.779668] livepatch: 'test_klp_state': starting patching transition
[  244.707041] livepatch: 'test_klp_state': completing patching transition
[  244.707171] test_klp_state: post_patch_callback: vmlinux
[  244.707172] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  244.707173] livepatch: 'test_klp_state': patching complete
[  244.801759] % modprobe test_klp_state2
[  244.803222] livepatch: enabling patch 'test_klp_state2'
[  244.803223] livepatch: 'test_klp_state2': initializing patching transition
[  244.803243] test_klp_state2: pre_patch_callback: vmlinux
[  244.803244] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  244.803245] livepatch: 'test_klp_state2': starting patching transition
[  245.747022] livepatch: 'test_klp_state2': completing patching transition
[  245.747131] test_klp_state2: post_patch_callback: vmlinux
[  245.747133] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  245.747134] livepatch: 'test_klp_state2': patching complete
[  245.822853] % rmmod test_klp_state
[  245.896693] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  245.896711] livepatch: 'test_klp_state2': initializing unpatching transition
[  245.896733] test_klp_state2: pre_unpatch_callback: vmlinux
[  245.896735] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  245.896736] livepatch: 'test_klp_state2': starting unpatching transition
[  247.666976] livepatch: 'test_klp_state2': completing unpatching transition
[  247.667145] test_klp_state2: post_unpatch_callback: vmlinux
[  247.667146] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  247.667147] livepatch: 'test_klp_state2': unpatching complete
[  247.712764] % rmmod test_klp_state2
[  247.774578] ===== TEST: compatible cumulative livepatches =====
[  247.777820] % modprobe test_klp_state2
[  247.779360] livepatch: enabling patch 'test_klp_state2'
[  247.779362] livepatch: 'test_klp_state2': initializing patching transition
[  247.779401] test_klp_state2: pre_patch_callback: vmlinux
[  247.779402] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  247.779403] livepatch: 'test_klp_state2': starting patching transition
[  248.706971] livepatch: 'test_klp_state2': completing patching transition
[  248.707111] test_klp_state2: post_patch_callback: vmlinux
[  248.707112] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  248.707114] livepatch: 'test_klp_state2': patching complete
[  248.800628] % modprobe test_klp_state3
[  248.802120] livepatch: enabling patch 'test_klp_state3'
[  248.802122] livepatch: 'test_klp_state3': initializing patching transition
[  248.802143] test_klp_state3: pre_patch_callback: vmlinux
[  248.802144] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  248.802145] livepatch: 'test_klp_state3': starting patching transition
[  249.747012] livepatch: 'test_klp_state3': completing patching transition
[  249.747117] test_klp_state3: post_patch_callback: vmlinux
[  249.747119] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  249.747120] livepatch: 'test_klp_state3': patching complete
[  249.821681] % rmmod test_klp_state2
[  249.889775] % modprobe test_klp_state2
[  249.891292] livepatch: enabling patch 'test_klp_state2'
[  249.891294] livepatch: 'test_klp_state2': initializing patching transition
[  249.891314] test_klp_state2: pre_patch_callback: vmlinux
[  249.891315] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  249.891317] livepatch: 'test_klp_state2': starting patching transition
[  250.706998] livepatch: 'test_klp_state2': completing patching transition
[  250.707174] test_klp_state2: post_patch_callback: vmlinux
[  250.707176] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  250.707177] livepatch: 'test_klp_state2': patching complete
[  250.808275] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  250.808295] livepatch: 'test_klp_state2': initializing unpatching transition
[  250.808317] test_klp_state2: pre_unpatch_callback: vmlinux
[  250.808318] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  250.808319] livepatch: 'test_klp_state2': starting unpatching transition
[  252.146949] livepatch: 'test_klp_state2': completing unpatching transition
[  252.147137] test_klp_state2: post_unpatch_callback: vmlinux
[  252.147139] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  252.147140] livepatch: 'test_klp_state2': unpatching complete
[  252.221718] % rmmod test_klp_state2
[  252.267508] % rmmod test_klp_state3
[  252.344651] ===== TEST: incompatible cumulative livepatches =====
[  252.347830] % modprobe test_klp_state2
[  252.349374] livepatch: enabling patch 'test_klp_state2'
[  252.349376] livepatch: 'test_klp_state2': initializing patching transition
[  252.349397] test_klp_state2: pre_patch_callback: vmlinux
[  252.349398] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  252.349399] livepatch: 'test_klp_state2': starting patching transition
[  253.666985] livepatch: 'test_klp_state2': completing patching transition
[  253.667137] test_klp_state2: post_patch_callback: vmlinux
[  253.667139] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  253.667140] livepatch: 'test_klp_state2': patching complete
[  253.672445] % modprobe test_klp_state
[  253.673955] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  253.836626] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  253.836711] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  253.836729] livepatch: 'test_klp_state2': initializing unpatching transition
[  253.836751] test_klp_state2: pre_unpatch_callback: vmlinux
[  253.836752] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  253.836753] livepatch: 'test_klp_state2': starting unpatching transition
[  255.107053] livepatch: 'test_klp_state2': completing unpatching transition
[  255.107160] test_klp_state2: post_unpatch_callback: vmlinux
[  255.107162] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  255.107163] livepatch: 'test_klp_state2': unpatching complete
[  255.149006] % rmmod test_klp_state2
[  255.251724] livepatch: kernel.ftrace_enabled = 1
[  255.259721] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  255.261663] livepatch: kernel.ftrace_enabled = 0
[  255.261800] % modprobe test_klp_livepatch
[  255.263372] livepatch: enabling patch 'test_klp_livepatch'
[  255.263374] livepatch: 'test_klp_livepatch': initializing patching transition
[  255.263397] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  255.263399] livepatch: failed to patch object 'vmlinux'
[  255.263400] livepatch: failed to enable patch 'test_klp_livepatch'
[  255.263401] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  255.263402] livepatch: 'test_klp_livepatch': completing unpatching transition
[  255.263560] livepatch: 'test_klp_livepatch': unpatching complete
[  255.386651] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  255.388605] livepatch: kernel.ftrace_enabled = 1
[  255.391657] % modprobe test_klp_livepatch
[  255.393208] livepatch: enabling patch 'test_klp_livepatch'
[  255.393210] livepatch: 'test_klp_livepatch': initializing patching transition
[  255.394450] livepatch: 'test_klp_livepatch': starting patching transition
[  256.786971] livepatch: 'test_klp_livepatch': completing patching transition
[  256.787078] livepatch: 'test_klp_livepatch': patching complete
[  256.823325] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  256.824273] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  256.824293] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  256.824311] livepatch: 'test_klp_livepatch': starting unpatching transition
[  257.746928] livepatch: 'test_klp_livepatch': completing unpatching transition
[  257.748446] livepatch: 'test_klp_livepatch': unpatching complete
[  257.833832] % rmmod test_klp_livepatch
[  257.929505] livepatch: kernel.ftrace_enabled = 1
[  257.936957] ===== TEST: sysfs test =====
[  257.940220] % modprobe test_klp_livepatch
[  257.941745] livepatch: enabling patch 'test_klp_livepatch'
[  257.941747] livepatch: 'test_klp_livepatch': initializing patching transition
[  257.942869] livepatch: 'test_klp_livepatch': starting patching transition
[  258.946982] livepatch: 'test_klp_livepatch': completing patching transition
[  258.947104] livepatch: 'test_klp_livepatch': patching complete
[  258.969357] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  258.969373] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  258.969393] livepatch: 'test_klp_livepatch': starting unpatching transition
[  260.716963] livepatch: 'test_klp_livepatch': completing unpatching transition
[  260.718450] livepatch: 'test_klp_livepatch': unpatching complete
[  260.785513] % rmmod test_klp_livepatch
[  260.874332] ===== TEST: sysfs test object/patched =====
[  260.877504] % modprobe test_klp_callbacks_demo
[  260.878941] livepatch: enabling patch 'test_klp_callbacks_demo'
[  260.878943] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  260.878965] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  260.878966] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  261.906924] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  261.907028] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  261.907030] livepatch: 'test_klp_callbacks_demo': patching complete
[  262.003387] % modprobe test_klp_callbacks_mod
[  262.004837] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  262.004839] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  262.004841] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  262.004883] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  262.007085] % rmmod test_klp_callbacks_mod
[  262.008282] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  262.008297] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  262.008299] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  262.008300] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  262.077659] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  262.077679] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  262.077698] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  262.077700] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  263.666952] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  263.667118] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  263.667119] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  263.692467] % rmmod test_klp_callbacks_demo

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="expect.txt"

% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="result.txt"

livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
test_klp_livepatch: this has been live patched
% modprobe test_klp_atomic_replace replace=0
livepatch: enabling patch 'test_klp_atomic_replace'
livepatch: 'test_klp_atomic_replace': initializing patching transition
livepatch: 'test_klp_atomic_replace': starting patching transition
livepatch: 'test_klp_atomic_replace': completing patching transition
livepatch: 'test_klp_atomic_replace': patching complete
test_klp_livepatch: this has been live patched
test_klp_atomic_replace: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
livepatch: 'test_klp_atomic_replace': initializing unpatching transition
livepatch: 'test_klp_atomic_replace': starting unpatching transition
livepatch: 'test_klp_atomic_replace': completing unpatching transition
livepatch: 'test_klp_atomic_replace': unpatching complete
% rmmod test_klp_atomic_replace
test_klp_livepatch: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
test_klp_livepatch: this has been live patched
% modprobe test_klp_atomic_replace replace=1
livepatch: enabling patch 'test_klp_atomic_replace'
livepatch: 'test_klp_atomic_replace': initializing patching transition
livepatch: 'test_klp_atomic_replace': starting patching transition
livepatch: 'test_klp_atomic_replace': completing patching transition
livepatch: 'test_klp_atomic_replace': patching complete
test_klp_atomic_replace: this has been live patched
% rmmod test_klp_livepatch
test_klp_atomic_replace: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
livepatch: 'test_klp_atomic_replace': initializing unpatching transition
livepatch: 'test_klp_atomic_replace': starting unpatching transition
livepatch: 'test_klp_atomic_replace': completing unpatching transition
livepatch: 'test_klp_atomic_replace': unpatching complete
% rmmod test_klp_atomic_replace
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo pre_patch_ret=-19
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: pre-patch callback failed for object 'vmlinux'
livepatch: failed to enable patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
livepatch: 'test_klp_callbacks_demo': unpatching complete
modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_busy block_transition=N
test_klp_callbacks_busy: test_klp_callbacks_busy_init
test_klp_callbacks_busy: busymod_work_func enter
test_klp_callbacks_busy: busymod_work_func exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_busy
test_klp_callbacks_busy: test_klp_callbacks_busy_exit
% modprobe test_klp_callbacks_busy block_transition=Y
test_klp_callbacks_busy: test_klp_callbacks_busy_init
test_klp_callbacks_busy: busymod_work_func enter
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_busy
test_klp_callbacks_busy: busymod_work_func exit
test_klp_callbacks_busy: test_klp_callbacks_busy_exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_demo2
livepatch: enabling patch 'test_klp_callbacks_demo2'
livepatch: 'test_klp_callbacks_demo2': initializing patching transition
test_klp_callbacks_demo2: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting patching transition
livepatch: 'test_klp_callbacks_demo2': completing patching transition
test_klp_callbacks_demo2: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': unpatching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo2
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_demo2 replace=1
livepatch: enabling patch 'test_klp_callbacks_demo2'
livepatch: 'test_klp_callbacks_demo2': initializing patching transition
test_klp_callbacks_demo2: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting patching transition
livepatch: 'test_klp_callbacks_demo2': completing patching transition
test_klp_callbacks_demo2: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': unpatching complete
% rmmod test_klp_callbacks_demo2
% rmmod test_klp_callbacks_demo
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_shadow_vars
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
test_klp_shadow_vars:   got expected NULL result
% rmmod test_klp_shadow_vars
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_state
livepatch: enabling patch 'test_klp_state'
livepatch: 'test_klp_state': initializing patching transition
test_klp_state: pre_patch_callback: vmlinux
test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state': starting patching transition
livepatch: 'test_klp_state': completing patching transition
test_klp_state: post_patch_callback: vmlinux
test_klp_state: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
livepatch: 'test_klp_state': initializing unpatching transition
test_klp_state: pre_unpatch_callback: vmlinux
test_klp_state: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state': starting unpatching transition
livepatch: 'test_klp_state': completing unpatching transition
test_klp_state: post_unpatch_callback: vmlinux
test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state': unpatching complete
% rmmod test_klp_state
% modprobe test_klp_state
livepatch: enabling patch 'test_klp_state'
livepatch: 'test_klp_state': initializing patching transition
test_klp_state: pre_patch_callback: vmlinux
test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state': starting patching transition
livepatch: 'test_klp_state': completing patching transition
test_klp_state: post_patch_callback: vmlinux
test_klp_state: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state': patching complete
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
livepatch: 'test_klp_state2': patching complete
% rmmod test_klp_state
% echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
livepatch: 'test_klp_state2': initializing unpatching transition
test_klp_state2: pre_unpatch_callback: vmlinux
test_klp_state2: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state2': starting unpatching transition
livepatch: 'test_klp_state2': completing unpatching transition
test_klp_state2: post_unpatch_callback: vmlinux
test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state2': unpatching complete
% rmmod test_klp_state2
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state2': patching complete
% modprobe test_klp_state3
livepatch: enabling patch 'test_klp_state3'
livepatch: 'test_klp_state3': initializing patching transition
test_klp_state3: pre_patch_callback: vmlinux
test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
livepatch: 'test_klp_state3': starting patching transition
livepatch: 'test_klp_state3': completing patching transition
test_klp_state3: post_patch_callback: vmlinux
test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
livepatch: 'test_klp_state3': patching complete
% rmmod test_klp_state2
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
livepatch: 'test_klp_state2': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
livepatch: 'test_klp_state2': initializing unpatching transition
test_klp_state2: pre_unpatch_callback: vmlinux
test_klp_state2: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state2': starting unpatching transition
livepatch: 'test_klp_state2': completing unpatching transition
test_klp_state2: post_unpatch_callback: vmlinux
test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state2': unpatching complete
% rmmod test_klp_state2
% rmmod test_klp_state3
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state2': patching complete
% modprobe test_klp_state
livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
% echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
livepatch: 'test_klp_state2': initializing unpatching transition
test_klp_state2: pre_unpatch_callback: vmlinux
test_klp_state2: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state2': starting unpatching transition
livepatch: 'test_klp_state2': completing unpatching transition
test_klp_state2: post_unpatch_callback: vmlinux
test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state2': unpatching complete
% rmmod test_klp_state2
livepatch: kernel.ftrace_enabled = 1
livepatch: kernel.ftrace_enabled = 0
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
livepatch: failed to patch object 'vmlinux'
livepatch: failed to enable patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
test_klp_livepatch: this has been live patched
% modprobe test_klp_atomic_replace replace=0
livepatch: enabling patch 'test_klp_atomic_replace'
livepatch: 'test_klp_atomic_replace': initializing patching transition
livepatch: 'test_klp_atomic_replace': starting patching transition
livepatch: 'test_klp_atomic_replace': completing patching transition
livepatch: 'test_klp_atomic_replace': patching complete
test_klp_livepatch: this has been live patched
test_klp_atomic_replace: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
livepatch: 'test_klp_atomic_replace': initializing unpatching transition
livepatch: 'test_klp_atomic_replace': starting unpatching transition
livepatch: 'test_klp_atomic_replace': completing unpatching transition
livepatch: 'test_klp_atomic_replace': unpatching complete
% rmmod test_klp_atomic_replace
test_klp_livepatch: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
test_klp_livepatch: this has been live patched
% modprobe test_klp_atomic_replace replace=1
livepatch: enabling patch 'test_klp_atomic_replace'
livepatch: 'test_klp_atomic_replace': initializing patching transition
livepatch: 'test_klp_atomic_replace': starting patching transition
livepatch: 'test_klp_atomic_replace': completing patching transition
livepatch: 'test_klp_atomic_replace': patching complete
test_klp_atomic_replace: this has been live patched
% rmmod test_klp_livepatch
test_klp_atomic_replace: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
livepatch: 'test_klp_atomic_replace': initializing unpatching transition
livepatch: 'test_klp_atomic_replace': starting unpatching transition
livepatch: 'test_klp_atomic_replace': completing unpatching transition
livepatch: 'test_klp_atomic_replace': unpatching complete
% rmmod test_klp_atomic_replace
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo pre_patch_ret=-19
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: pre-patch callback failed for object 'vmlinux'
livepatch: failed to enable patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
livepatch: 'test_klp_callbacks_demo': unpatching complete
modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_busy block_transition=N
test_klp_callbacks_busy: test_klp_callbacks_busy_init
test_klp_callbacks_busy: busymod_work_func enter
test_klp_callbacks_busy: busymod_work_func exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_busy
test_klp_callbacks_busy: test_klp_callbacks_busy_exit
% modprobe test_klp_callbacks_busy block_transition=Y
test_klp_callbacks_busy: test_klp_callbacks_busy_init
test_klp_callbacks_busy: busymod_work_func enter
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_busy
test_klp_callbacks_busy: busymod_work_func exit
test_klp_callbacks_busy: test_klp_callbacks_busy_exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_demo2
livepatch: enabling patch 'test_klp_callbacks_demo2'
livepatch: 'test_klp_callbacks_demo2': initializing patching transition
test_klp_callbacks_demo2: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting patching transition
livepatch: 'test_klp_callbacks_demo2': completing patching transition
test_klp_callbacks_demo2: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': unpatching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo2
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_demo2 replace=1
livepatch: enabling patch 'test_klp_callbacks_demo2'
livepatch: 'test_klp_callbacks_demo2': initializing patching transition
test_klp_callbacks_demo2: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting patching transition
livepatch: 'test_klp_callbacks_demo2': completing patching transition
test_klp_callbacks_demo2: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo2': unpatching complete
% rmmod test_klp_callbacks_demo2
% rmmod test_klp_callbacks_demo
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_shadow_vars
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
test_klp_shadow_vars:   got expected NULL result
test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
test_klp_shadow_vars:   got expected NULL result
% rmmod test_klp_shadow_vars
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_state
livepatch: enabling patch 'test_klp_state'
livepatch: 'test_klp_state': initializing patching transition
test_klp_state: pre_patch_callback: vmlinux
test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state': starting patching transition
livepatch: 'test_klp_state': completing patching transition
test_klp_state: post_patch_callback: vmlinux
test_klp_state: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
livepatch: 'test_klp_state': initializing unpatching transition
test_klp_state: pre_unpatch_callback: vmlinux
test_klp_state: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state': starting unpatching transition
livepatch: 'test_klp_state': completing unpatching transition
test_klp_state: post_unpatch_callback: vmlinux
test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state': unpatching complete
% rmmod test_klp_state
% modprobe test_klp_state
livepatch: enabling patch 'test_klp_state'
livepatch: 'test_klp_state': initializing patching transition
test_klp_state: pre_patch_callback: vmlinux
test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state': starting patching transition
livepatch: 'test_klp_state': completing patching transition
test_klp_state: post_patch_callback: vmlinux
test_klp_state: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state': patching complete
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
livepatch: 'test_klp_state2': patching complete
% rmmod test_klp_state
% echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
livepatch: 'test_klp_state2': initializing unpatching transition
test_klp_state2: pre_unpatch_callback: vmlinux
test_klp_state2: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state2': starting unpatching transition
livepatch: 'test_klp_state2': completing unpatching transition
test_klp_state2: post_unpatch_callback: vmlinux
test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state2': unpatching complete
% rmmod test_klp_state2
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state2': patching complete
% modprobe test_klp_state3
livepatch: enabling patch 'test_klp_state3'
livepatch: 'test_klp_state3': initializing patching transition
test_klp_state3: pre_patch_callback: vmlinux
test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
livepatch: 'test_klp_state3': starting patching transition
livepatch: 'test_klp_state3': completing patching transition
test_klp_state3: post_patch_callback: vmlinux
test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
livepatch: 'test_klp_state3': patching complete
% rmmod test_klp_state2
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
livepatch: 'test_klp_state2': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
livepatch: 'test_klp_state2': initializing unpatching transition
test_klp_state2: pre_unpatch_callback: vmlinux
test_klp_state2: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state2': starting unpatching transition
livepatch: 'test_klp_state2': completing unpatching transition
test_klp_state2: post_unpatch_callback: vmlinux
test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state2': unpatching complete
% rmmod test_klp_state2
% rmmod test_klp_state3
% modprobe test_klp_state2
livepatch: enabling patch 'test_klp_state2'
livepatch: 'test_klp_state2': initializing patching transition
test_klp_state2: pre_patch_callback: vmlinux
test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
livepatch: 'test_klp_state2': starting patching transition
livepatch: 'test_klp_state2': completing patching transition
test_klp_state2: post_patch_callback: vmlinux
test_klp_state2: fix_console_loglevel: fixing console_loglevel
livepatch: 'test_klp_state2': patching complete
% modprobe test_klp_state
livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
% echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
livepatch: 'test_klp_state2': initializing unpatching transition
test_klp_state2: pre_unpatch_callback: vmlinux
test_klp_state2: restore_console_loglevel: restoring console_loglevel
livepatch: 'test_klp_state2': starting unpatching transition
livepatch: 'test_klp_state2': completing unpatching transition
test_klp_state2: post_unpatch_callback: vmlinux
test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
livepatch: 'test_klp_state2': unpatching complete
% rmmod test_klp_state2
livepatch: kernel.ftrace_enabled = 1
livepatch: kernel.ftrace_enabled = 0
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
livepatch: failed to patch object 'vmlinux'
livepatch: failed to enable patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
test_klp_livepatch: this has been live patched
% modprobe test_klp_atomic_replace replace=0
livepatch: enabling patch 'test_klp_atomic_replace'
livepatch: 'test_klp_atomic_replace': initializing patching transition
livepatch: 'test_klp_atomic_replace': starting patching transition
livepatch: 'test_klp_atomic_replace': completing patching transition
livepatch: 'test_klp_atomic_replace': patching complete
test_klp_livepatch: this has been live patched
test_klp_atomic_replace: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
livepatch: 'test_klp_atomic_replace': initializing unpatching transition
livepatch: 'test_klp_atomic_replace': starting unpatching transition
livepatch: 'test_klp_atomic_replace': completing unpatching transition
livepatch: 'test_klp_atomic_replace': unpatching complete
% rmmod test_klp_atomic_replace
test_klp_livepatch: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
livepatch: 'test_klp_livepatch': initializing unpatching transition
livepatch: 'test_klp_livepatch': starting unpatching transition
livepatch: 'test_klp_livepatch': completing unpatching transition
livepatch: 'test_klp_livepatch': unpatching complete
% rmmod test_klp_livepatch
% modprobe test_klp_livepatch
livepatch: enabling patch 'test_klp_livepatch'
livepatch: 'test_klp_livepatch': initializing patching transition
livepatch: 'test_klp_livepatch': starting patching transition
livepatch: 'test_klp_livepatch': completing patching transition
livepatch: 'test_klp_livepatch': patching complete
test_klp_livepatch: this has been live patched
% modprobe test_klp_atomic_replace replace=1
livepatch: enabling patch 'test_klp_atomic_replace'
livepatch: 'test_klp_atomic_replace': initializing patching transition
livepatch: 'test_klp_atomic_replace': starting patching transition
livepatch: 'test_klp_atomic_replace': completing patching transition
livepatch: 'test_klp_atomic_replace': patching complete
test_klp_atomic_replace: this has been live patched
% rmmod test_klp_livepatch
test_klp_atomic_replace: this has been live patched
% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
livepatch: 'test_klp_atomic_replace': initializing unpatching transition
livepatch: 'test_klp_atomic_replace': starting unpatching transition
livepatch: 'test_klp_atomic_replace': completing unpatching transition
livepatch: 'test_klp_atomic_replace': unpatching complete
% rmmod test_klp_atomic_replace
livepatch: kernel.ftrace_enabled = 1
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
% modprobe test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
livepatch: 'test_klp_callbacks_demo': patching complete
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% modprobe test_klp_callbacks_mod
livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
test_klp_callbacks_mod: test_klp_callbacks_mod_init
% rmmod test_klp_callbacks_mod
test_klp_callbacks_mod: test_klp_callbacks_mod_exit
test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo
% modprobe test_klp_callbacks_demo
livepatch: enabling patch 'test_klp_callbacks_demo'
livepatch: 'test_klp_callbacks_demo': initializing patching transition
test_klp_callbacks_demo: pre_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting patching transition
livepatch: 'test_klp_callbacks_demo': completing patching transition
test_klp_callbacks_demo: post_patch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': patching complete
% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': starting unpatching transition
livepatch: 'test_klp_callbacks_demo': completing unpatching transition
test_klp_callbacks_demo: post_unpatch_callback: vmlinux
livepatch: 'test_klp_callbacks_demo': unpatching complete
% rmmod test_klp_callbacks_demo

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-saved1.txt"

[   91.923385] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[   91.923387] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[   91.923388] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[   91.923389] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[   91.923403] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[   91.923404] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[   91.923405] test_klp_shadow_vars:   got expected NULL result
[   91.923406] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[   91.923408] test_klp_shadow_vars:   got expected NULL result
[   91.923408] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[   91.923410] test_klp_shadow_vars:   got expected NULL result
[   91.924707] % rmmod test_klp_shadow_vars
[   92.043422] livepatch: kernel.ftrace_enabled = 1
[   92.049886] ===== TEST: system state modification =====
[   92.053102] % modprobe test_klp_state
[   92.054575] livepatch: enabling patch 'test_klp_state'
[   92.054577] livepatch: 'test_klp_state': initializing patching transition
[   92.054599] test_klp_state: pre_patch_callback: vmlinux
[   92.054600] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[   92.054601] livepatch: 'test_klp_state': starting patching transition
[   92.911051] livepatch: 'test_klp_state': completing patching transition
[   92.911154] test_klp_state: post_patch_callback: vmlinux
[   92.911156] test_klp_state: fix_console_loglevel: fixing console_loglevel
[   92.911157] livepatch: 'test_klp_state': patching complete
[   92.971706] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[   92.971726] livepatch: 'test_klp_state': initializing unpatching transition
[   92.971748] test_klp_state: pre_unpatch_callback: vmlinux
[   92.971749] test_klp_state: restore_console_loglevel: restoring console_loglevel
[   92.971750] livepatch: 'test_klp_state': starting unpatching transition
[   94.751032] livepatch: 'test_klp_state': completing unpatching transition
[   94.751134] test_klp_state: post_unpatch_callback: vmlinux
[   94.751136] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[   94.751137] livepatch: 'test_klp_state': unpatching complete
[   94.788056] % rmmod test_klp_state
[   94.845476] ===== TEST: taking over system state modification =====
[   94.848473] % modprobe test_klp_state
[   94.849942] livepatch: enabling patch 'test_klp_state'
[   94.849944] livepatch: 'test_klp_state': initializing patching transition
[   94.849964] test_klp_state: pre_patch_callback: vmlinux
[   94.849965] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[   94.849966] livepatch: 'test_klp_state': starting patching transition
[   95.711025] livepatch: 'test_klp_state': completing patching transition
[   95.711177] test_klp_state: post_patch_callback: vmlinux
[   95.711179] test_klp_state: fix_console_loglevel: fixing console_loglevel
[   95.711180] livepatch: 'test_klp_state': patching complete
[   95.770236] % modprobe test_klp_state2
[   95.771616] livepatch: enabling patch 'test_klp_state2'
[   95.771618] livepatch: 'test_klp_state2': initializing patching transition
[   95.771638] test_klp_state2: pre_patch_callback: vmlinux
[   95.771639] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[   95.771641] livepatch: 'test_klp_state2': starting patching transition
[   97.081037] livepatch: 'test_klp_state2': completing patching transition
[   97.081197] test_klp_state2: post_patch_callback: vmlinux
[   97.081198] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[   97.081199] livepatch: 'test_klp_state2': patching complete
[   97.096083] % rmmod test_klp_state
[   97.140728] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[   97.140747] livepatch: 'test_klp_state2': initializing unpatching transition
[   97.140768] test_klp_state2: pre_unpatch_callback: vmlinux
[   97.140769] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[   97.140770] livepatch: 'test_klp_state2': starting unpatching transition
[   98.671037] livepatch: 'test_klp_state2': completing unpatching transition
[   98.671175] test_klp_state2: post_unpatch_callback: vmlinux
[   98.671177] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[   98.671179] livepatch: 'test_klp_state2': unpatching complete
[   98.755809] % rmmod test_klp_state2
[   98.815472] ===== TEST: compatible cumulative livepatches =====
[   98.818642] % modprobe test_klp_state2
[   98.820299] livepatch: enabling patch 'test_klp_state2'
[   98.820301] livepatch: 'test_klp_state2': initializing patching transition
[   98.820328] test_klp_state2: pre_patch_callback: vmlinux
[   98.820330] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[   98.820331] livepatch: 'test_klp_state2': starting patching transition
[  100.031067] livepatch: 'test_klp_state2': completing patching transition
[  100.031184] test_klp_state2: post_patch_callback: vmlinux
[  100.031185] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  100.031187] livepatch: 'test_klp_state2': patching complete
[  100.045573] % modprobe test_klp_state3
[  100.047069] livepatch: enabling patch 'test_klp_state3'
[  100.047072] livepatch: 'test_klp_state3': initializing patching transition
[  100.047093] test_klp_state3: pre_patch_callback: vmlinux
[  100.047094] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  100.047095] livepatch: 'test_klp_state3': starting patching transition
[  101.711037] livepatch: 'test_klp_state3': completing patching transition
[  101.711204] test_klp_state3: post_patch_callback: vmlinux
[  101.711206] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  101.711207] livepatch: 'test_klp_state3': patching complete
[  101.778205] % rmmod test_klp_state2
[  101.853923] % modprobe test_klp_state2
[  101.855447] livepatch: enabling patch 'test_klp_state2'
[  101.855449] livepatch: 'test_klp_state2': initializing patching transition
[  101.855470] test_klp_state2: pre_patch_callback: vmlinux
[  101.855472] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  101.855473] livepatch: 'test_klp_state2': starting patching transition
[  103.630965] livepatch: 'test_klp_state2': completing patching transition
[  103.631070] test_klp_state2: post_patch_callback: vmlinux
[  103.631071] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  103.631073] livepatch: 'test_klp_state2': patching complete
[  103.686892] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  103.686911] livepatch: 'test_klp_state2': initializing unpatching transition
[  103.686932] test_klp_state2: pre_unpatch_callback: vmlinux
[  103.686933] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  103.686935] livepatch: 'test_klp_state2': starting unpatching transition
[  105.150996] livepatch: 'test_klp_state2': completing unpatching transition
[  105.151097] test_klp_state2: post_unpatch_callback: vmlinux
[  105.151099] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  105.151100] livepatch: 'test_klp_state2': unpatching complete
[  105.199966] % rmmod test_klp_state2
[  105.281410] % rmmod test_klp_state3
[  105.355459] ===== TEST: incompatible cumulative livepatches =====
[  105.358650] % modprobe test_klp_state2
[  105.360034] livepatch: enabling patch 'test_klp_state2'
[  105.360035] livepatch: 'test_klp_state2': initializing patching transition
[  105.360056] test_klp_state2: pre_patch_callback: vmlinux
[  105.360057] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  105.360058] livepatch: 'test_klp_state2': starting patching transition
[  107.071045] livepatch: 'test_klp_state2': completing patching transition
[  107.071145] test_klp_state2: post_patch_callback: vmlinux
[  107.071147] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  107.071148] livepatch: 'test_klp_state2': patching complete
[  107.087110] % modprobe test_klp_state
[  107.088695] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  107.190677] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  107.190716] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  107.190734] livepatch: 'test_klp_state2': initializing unpatching transition
[  107.190753] test_klp_state2: pre_unpatch_callback: vmlinux
[  107.190754] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  107.190755] livepatch: 'test_klp_state2': starting unpatching transition
[  108.111015] livepatch: 'test_klp_state2': completing unpatching transition
[  108.111118] test_klp_state2: post_unpatch_callback: vmlinux
[  108.111120] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  108.111121] livepatch: 'test_klp_state2': unpatching complete
[  108.200035] % rmmod test_klp_state2
[  108.301787] livepatch: kernel.ftrace_enabled = 1
[  108.308056] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  108.309828] livepatch: kernel.ftrace_enabled = 0
[  108.309890] % modprobe test_klp_livepatch
[  108.311242] livepatch: enabling patch 'test_klp_livepatch'
[  108.311244] livepatch: 'test_klp_livepatch': initializing patching transition
[  108.311267] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  108.311270] livepatch: failed to patch object 'vmlinux'
[  108.311271] livepatch: failed to enable patch 'test_klp_livepatch'
[  108.311272] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  108.311273] livepatch: 'test_klp_livepatch': completing unpatching transition
[  108.311382] livepatch: 'test_klp_livepatch': unpatching complete
[  108.500681] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  108.502529] livepatch: kernel.ftrace_enabled = 1
[  108.505528] % modprobe test_klp_livepatch
[  108.506881] livepatch: enabling patch 'test_klp_livepatch'
[  108.506882] livepatch: 'test_klp_livepatch': initializing patching transition
[  108.508030] livepatch: 'test_klp_livepatch': starting patching transition
[  109.790992] livepatch: 'test_klp_livepatch': completing patching transition
[  109.791146] livepatch: 'test_klp_livepatch': patching complete
[  109.834645] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  109.835658] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  109.835676] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  109.835692] livepatch: 'test_klp_livepatch': starting unpatching transition
[  110.831016] livepatch: 'test_klp_livepatch': completing unpatching transition
[  110.832521] livepatch: 'test_klp_livepatch': unpatching complete
[  110.845082] % rmmod test_klp_livepatch
[  110.962324] livepatch: kernel.ftrace_enabled = 1
[  110.969070] ===== TEST: sysfs test =====
[  110.972147] % modprobe test_klp_livepatch
[  110.973575] livepatch: enabling patch 'test_klp_livepatch'
[  110.973578] livepatch: 'test_klp_livepatch': initializing patching transition
[  110.974676] livepatch: 'test_klp_livepatch': starting patching transition
[  112.671034] livepatch: 'test_klp_livepatch': completing patching transition
[  112.671137] livepatch: 'test_klp_livepatch': patching complete
[  112.711815] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  112.711832] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  112.711853] livepatch: 'test_klp_livepatch': starting unpatching transition
[  113.711046] livepatch: 'test_klp_livepatch': completing unpatching transition
[  113.712556] livepatch: 'test_klp_livepatch': unpatching complete
[  113.721666] % rmmod test_klp_livepatch
[  113.786348] ===== TEST: sysfs test object/patched =====
[  113.789508] % modprobe test_klp_callbacks_demo
[  113.791059] livepatch: enabling patch 'test_klp_callbacks_demo'
[  113.791061] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  113.791082] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  113.791083] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  114.831046] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  114.831155] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  114.831157] livepatch: 'test_klp_callbacks_demo': patching complete
[  114.915700] % modprobe test_klp_callbacks_mod
[  114.917199] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  114.917201] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  114.917203] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  114.917220] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  114.919407] % rmmod test_klp_callbacks_mod
[  114.920563] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  114.920578] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  114.920580] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  114.920582] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  114.991648] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  114.991667] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  114.991690] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  114.991692] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  116.671055] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  116.671159] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  116.671177] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  116.706610] % rmmod test_klp_callbacks_demo
[  116.853345] livepatch: kernel.ftrace_enabled = 1
[  116.860222] ===== TEST: basic function patching =====
[  116.863329] % modprobe test_klp_livepatch
[  116.864936] livepatch: enabling patch 'test_klp_livepatch'
[  116.864938] livepatch: 'test_klp_livepatch': initializing patching transition
[  116.866224] livepatch: 'test_klp_livepatch': starting patching transition
[  117.791071] livepatch: 'test_klp_livepatch': completing patching transition
[  117.791193] livepatch: 'test_klp_livepatch': patching complete
[  117.885360] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  117.885397] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  117.885424] livepatch: 'test_klp_livepatch': starting unpatching transition
[  118.750980] livepatch: 'test_klp_livepatch': completing unpatching transition
[  118.752543] livepatch: 'test_klp_livepatch': unpatching complete
[  118.794530] % rmmod test_klp_livepatch
[  118.897157] ===== TEST: multiple livepatches =====
[  118.900009] % modprobe test_klp_livepatch
[  118.901338] livepatch: enabling patch 'test_klp_livepatch'
[  118.901341] livepatch: 'test_klp_livepatch': initializing patching transition
[  118.902413] livepatch: 'test_klp_livepatch': starting patching transition
[  119.711012] livepatch: 'test_klp_livepatch': completing patching transition
[  119.711114] livepatch: 'test_klp_livepatch': patching complete
[  119.718796] test_klp_livepatch: this has been live patched
[  119.723001] % modprobe test_klp_atomic_replace replace=0
[  119.724612] livepatch: enabling patch 'test_klp_atomic_replace'
[  119.724614] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  119.725833] livepatch: 'test_klp_atomic_replace': starting patching transition
[  120.751022] livepatch: 'test_klp_atomic_replace': completing patching transition
[  120.751130] livepatch: 'test_klp_atomic_replace': patching complete
[  120.847005] test_klp_livepatch: this has been live patched
[  120.847986] test_klp_atomic_replace: this has been live patched
[  120.848118] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  120.848138] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  120.848158] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  121.710988] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  121.712378] livepatch: 'test_klp_atomic_replace': unpatching complete
[  121.757104] % rmmod test_klp_atomic_replace
[  121.801514] test_klp_livepatch: this has been live patched
[  121.802520] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  121.802538] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  121.802554] livepatch: 'test_klp_livepatch': starting unpatching transition
[  122.761006] livepatch: 'test_klp_livepatch': completing unpatching transition
[  122.762405] livepatch: 'test_klp_livepatch': unpatching complete
[  122.812386] % rmmod test_klp_livepatch
[  122.888229] ===== TEST: atomic replace livepatch =====
[  122.891365] % modprobe test_klp_livepatch
[  122.892757] livepatch: enabling patch 'test_klp_livepatch'
[  122.892759] livepatch: 'test_klp_livepatch': initializing patching transition
[  122.893900] livepatch: 'test_klp_livepatch': starting patching transition
[  123.871073] livepatch: 'test_klp_livepatch': completing patching transition
[  123.871179] livepatch: 'test_klp_livepatch': patching complete
[  123.913201] test_klp_livepatch: this has been live patched
[  123.917508] % modprobe test_klp_atomic_replace replace=1
[  123.918994] livepatch: enabling patch 'test_klp_atomic_replace'
[  123.918996] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  123.920106] livepatch: 'test_klp_atomic_replace': starting patching transition
[  124.751016] livepatch: 'test_klp_atomic_replace': completing patching transition
[  124.752390] livepatch: 'test_klp_atomic_replace': patching complete
[  124.838483] test_klp_atomic_replace: this has been live patched
[  124.839576] % rmmod test_klp_livepatch
[  124.892319] test_klp_atomic_replace: this has been live patched
[  124.892494] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  124.892513] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  124.892529] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  125.711010] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  125.712510] livepatch: 'test_klp_atomic_replace': unpatching complete
[  125.801651] % rmmod test_klp_atomic_replace
[  125.905407] livepatch: kernel.ftrace_enabled = 1
[  125.912644] ===== TEST: target module before livepatch =====
[  125.915835] % modprobe test_klp_callbacks_mod
[  125.917236] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  125.920790] % modprobe test_klp_callbacks_demo
[  125.922345] livepatch: enabling patch 'test_klp_callbacks_demo'
[  125.922347] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  125.922366] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  125.922367] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  125.922369] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  127.711053] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  127.711189] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  127.711191] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  127.711193] livepatch: 'test_klp_callbacks_demo': patching complete
[  127.755072] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  127.755091] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  127.755106] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  127.755107] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  127.755109] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  128.671068] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  128.671171] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  128.671172] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  128.671174] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  128.765224] % rmmod test_klp_callbacks_demo
[  128.811614] % rmmod test_klp_callbacks_mod
[  128.812787] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  128.887174] ===== TEST: module_coming notifier =====
[  128.890422] % modprobe test_klp_callbacks_demo
[  128.892042] livepatch: enabling patch 'test_klp_callbacks_demo'
[  128.892045] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  128.892067] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  128.892068] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  129.791064] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  129.791173] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  129.791175] livepatch: 'test_klp_callbacks_demo': patching complete
[  129.812482] % modprobe test_klp_callbacks_mod
[  129.813968] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  129.813971] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  129.813973] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  129.813990] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  129.814364] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  129.814383] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  129.814404] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  129.814405] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  129.814407] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  130.671041] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  130.671174] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  130.671176] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  130.671178] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  130.723905] % rmmod test_klp_callbacks_demo
[  130.771625] % rmmod test_klp_callbacks_mod
[  130.772641] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  130.826909] ===== TEST: module_going notifier =====
[  130.830202] % modprobe test_klp_callbacks_mod
[  130.831538] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  130.834984] % modprobe test_klp_callbacks_demo
[  130.836549] livepatch: enabling patch 'test_klp_callbacks_demo'
[  130.836552] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  130.836573] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  130.836574] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  130.836576] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  131.710974] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  131.711075] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  131.711077] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  131.711079] livepatch: 'test_klp_callbacks_demo': patching complete
[  131.754244] % rmmod test_klp_callbacks_mod
[  131.755454] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  131.755471] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  131.755473] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  131.755475] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  131.800736] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  131.800754] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  131.800775] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  131.800776] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  133.071027] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  133.071132] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  133.071134] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  133.113297] % rmmod test_klp_callbacks_demo
[  133.177434] ===== TEST: module_coming and module_going notifiers =====
[  133.180622] % modprobe test_klp_callbacks_demo
[  133.182228] livepatch: enabling patch 'test_klp_callbacks_demo'
[  133.182231] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  133.182251] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  133.182252] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  134.751073] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  134.751184] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  134.751187] livepatch: 'test_klp_callbacks_demo': patching complete
[  134.813811] % modprobe test_klp_callbacks_mod
[  134.815280] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  134.815282] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  134.815284] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  134.815302] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  134.816526] % rmmod test_klp_callbacks_mod
[  134.817758] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  134.817773] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  134.817775] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  134.817776] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  134.940787] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  134.940806] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  134.940828] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  134.940829] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  135.950967] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  135.951069] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  135.951071] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  136.051536] % rmmod test_klp_callbacks_demo
[  136.117597] ===== TEST: target module not present =====
[  136.120836] % modprobe test_klp_callbacks_demo
[  136.122441] livepatch: enabling patch 'test_klp_callbacks_demo'
[  136.122444] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  136.122476] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  136.122477] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  137.871054] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  137.871179] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  137.871181] livepatch: 'test_klp_callbacks_demo': patching complete
[  137.952610] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  137.952631] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  137.952666] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  137.952668] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  139.071051] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  139.071152] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  139.071154] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  139.164250] % rmmod test_klp_callbacks_demo
[  139.257782] ===== TEST: pre-patch callback -ENODEV =====
[  139.260610] % modprobe test_klp_callbacks_mod
[  139.261932] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  139.262266] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  139.263690] livepatch: enabling patch 'test_klp_callbacks_demo'
[  139.263692] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  139.263711] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  139.263712] livepatch: pre-patch callback failed for object 'vmlinux'
[  139.263713] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  139.263714] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  139.263715] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  139.263820] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  139.410666] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  139.411683] % rmmod test_klp_callbacks_mod
[  139.412838] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  139.477858] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  139.480794] % modprobe test_klp_callbacks_demo
[  139.482279] livepatch: enabling patch 'test_klp_callbacks_demo'
[  139.482282] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  139.482303] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  139.482304] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  140.831122] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  140.831279] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  140.831281] livepatch: 'test_klp_callbacks_demo': patching complete
[  140.908032] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  140.908963] % modprobe test_klp_callbacks_mod
[  140.910243] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  140.910246] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  140.910248] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  140.910249] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  141.030671] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  141.030722] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  141.030738] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  141.030776] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  141.030777] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  141.789613] crw_info : CRW reports slct=0, oflw=0, chn=0, rsc=B, anc=0, erc=0, rsid=0
[  142.031077] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  142.031196] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  142.031198] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  142.041387] % rmmod test_klp_callbacks_demo
[  142.108391] ===== TEST: multiple target modules =====
[  142.111495] % modprobe test_klp_callbacks_busy block_transition=N
[  142.112950] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  142.112954] test_klp_callbacks_busy: busymod_work_func enter
[  142.112956] test_klp_callbacks_busy: busymod_work_func exit
[  142.116379] % modprobe test_klp_callbacks_demo
[  142.117801] livepatch: enabling patch 'test_klp_callbacks_demo'
[  142.117802] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  142.117840] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  142.117841] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  142.119215] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  143.070935] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  143.071035] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  143.071037] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  143.071039] livepatch: 'test_klp_callbacks_demo': patching complete
[  143.141657] % modprobe test_klp_callbacks_mod
[  143.143195] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  143.143198] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.143200] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.143236] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  143.144563] % rmmod test_klp_callbacks_mod
[  143.145857] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  143.145873] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.145875] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  143.145876] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.220815] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  143.220851] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  143.220872] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  143.220873] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  143.220875] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  144.031007] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  144.032819] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  144.032821] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  144.032822] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  144.130433] % rmmod test_klp_callbacks_demo
[  144.211697] % rmmod test_klp_callbacks_busy
[  144.213003] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  144.308603] ===== TEST: busy target module =====
[  144.311786] % modprobe test_klp_callbacks_busy block_transition=Y
[  144.313186] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  144.313190] test_klp_callbacks_busy: busymod_work_func enter
[  144.316644] % modprobe test_klp_callbacks_demo
[  144.318094] livepatch: enabling patch 'test_klp_callbacks_demo'
[  144.318095] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  144.318115] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  144.318116] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  144.319516] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  144.324787] % modprobe test_klp_callbacks_mod
[  144.326157] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  144.326159] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  144.326174] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  144.327454] % rmmod test_klp_callbacks_mod
[  144.328546] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  144.328561] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  144.328563] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  144.410842] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  144.410861] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  144.410966] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  146.990932] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  146.992683] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  146.992685] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  146.992687] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  147.033638] % rmmod test_klp_callbacks_demo
[  147.121645] % rmmod test_klp_callbacks_busy
[  147.130314] test_klp_callbacks_busy: busymod_work_func exit
[  147.130323] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  147.208177] ===== TEST: multiple livepatches =====
[  147.211079] % modprobe test_klp_callbacks_demo
[  147.212707] livepatch: enabling patch 'test_klp_callbacks_demo'
[  147.212710] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  147.212730] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  147.212731] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  148.031059] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  148.031160] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  148.031162] livepatch: 'test_klp_callbacks_demo': patching complete
[  148.132098] % modprobe test_klp_callbacks_demo2
[  148.133641] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  148.133644] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  148.133664] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  148.133666] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  149.151067] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  149.151184] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  149.151186] livepatch: 'test_klp_callbacks_demo2': patching complete
[  149.152975] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  149.152995] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  149.153015] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  149.153016] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  149.951022] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  149.951125] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  149.951127] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  149.960854] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  149.960873] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  149.960888] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  149.960890] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  150.991050] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  150.991152] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  150.991154] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  151.071631] % rmmod test_klp_callbacks_demo2
[  151.131726] % rmmod test_klp_callbacks_demo
[  151.229250] ===== TEST: atomic replace =====
[  151.232455] % modprobe test_klp_callbacks_demo
[  151.234085] livepatch: enabling patch 'test_klp_callbacks_demo'
[  151.234087] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  151.234107] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  151.234108] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  152.031077] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  152.031231] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  152.031233] livepatch: 'test_klp_callbacks_demo': patching complete
[  152.052914] % modprobe test_klp_callbacks_demo2 replace=1
[  152.054593] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  152.054595] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  152.054616] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  152.054618] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  153.071103] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  153.071224] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  153.071226] livepatch: 'test_klp_callbacks_demo2': patching complete
[  153.073798] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  153.073819] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  153.073840] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  153.073841] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  154.031008] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  154.031113] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  154.031116] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  154.084458] % rmmod test_klp_callbacks_demo2
[  154.161744] % rmmod test_klp_callbacks_demo
[  154.245192] livepatch: kernel.ftrace_enabled = 1
[  154.253557] ===== TEST: basic shadow variable API =====
[  154.256693] % modprobe test_klp_shadow_vars
[  154.258215] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  154.258218] test_klp_shadow_vars:   got expected NULL result
[  154.258220] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  154.258221] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  154.258224] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  154.258226] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  154.258228] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  154.258229] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  154.258232] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  154.258233] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  154.258235] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  154.258236] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  154.258239] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  154.258240] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  154.258242] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  154.258243] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  154.258244] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  154.258246] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  154.258268] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  154.258269] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  154.258270] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  154.258271] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  154.258273] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  154.258274] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  154.258275] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  154.258276] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  154.258278] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  154.258280] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  154.258281] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  154.258283] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  154.258284] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  154.258286] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  154.258287] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  154.258289] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  154.258290] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  154.258292] test_klp_shadow_vars:   got expected NULL result
[  154.258292] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  154.258294] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  154.258295] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  154.258297] test_klp_shadow_vars:   got expected NULL result
[  154.258297] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  154.258299] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  154.258300] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  154.258301] test_klp_shadow_vars:   got expected NULL result
[  154.258302] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  154.258303] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  154.258304] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  154.258306] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  154.258307] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  154.258308] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  154.258317] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  154.258318] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  154.258319] test_klp_shadow_vars:   got expected NULL result
[  154.258320] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  154.258321] test_klp_shadow_vars:   got expected NULL result
[  154.258322] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  154.258323] test_klp_shadow_vars:   got expected NULL result
[  154.259549] % rmmod test_klp_shadow_vars
[  154.364539] livepatch: kernel.ftrace_enabled = 1
[  154.373051] ===== TEST: system state modification =====
[  154.376288] % modprobe test_klp_state
[  154.377808] livepatch: enabling patch 'test_klp_state'
[  154.377810] livepatch: 'test_klp_state': initializing patching transition
[  154.377832] test_klp_state: pre_patch_callback: vmlinux
[  154.377833] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  154.377834] livepatch: 'test_klp_state': starting patching transition
[  155.951098] livepatch: 'test_klp_state': completing patching transition
[  155.951196] test_klp_state: post_patch_callback: vmlinux
[  155.951198] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  155.951199] livepatch: 'test_klp_state': patching complete
[  156.005967] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  156.005986] livepatch: 'test_klp_state': initializing unpatching transition
[  156.006003] test_klp_state: pre_unpatch_callback: vmlinux
[  156.006004] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  156.006005] livepatch: 'test_klp_state': starting unpatching transition
[  156.991099] livepatch: 'test_klp_state': completing unpatching transition
[  156.991197] test_klp_state: post_unpatch_callback: vmlinux
[  156.991199] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  156.991201] livepatch: 'test_klp_state': unpatching complete
[  157.016096] % rmmod test_klp_state
[  157.119439] ===== TEST: taking over system state modification =====
[  157.122658] % modprobe test_klp_state
[  157.124299] livepatch: enabling patch 'test_klp_state'
[  157.124302] livepatch: 'test_klp_state': initializing patching transition
[  157.124324] test_klp_state: pre_patch_callback: vmlinux
[  157.124325] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  157.124326] livepatch: 'test_klp_state': starting patching transition
[  158.031004] livepatch: 'test_klp_state': completing patching transition
[  158.031105] test_klp_state: post_patch_callback: vmlinux
[  158.031107] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  158.031109] livepatch: 'test_klp_state': patching complete
[  158.044647] % modprobe test_klp_state2
[  158.046174] livepatch: enabling patch 'test_klp_state2'
[  158.046176] livepatch: 'test_klp_state2': initializing patching transition
[  158.046194] test_klp_state2: pre_patch_callback: vmlinux
[  158.046195] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  158.046197] livepatch: 'test_klp_state2': starting patching transition
[  158.991060] livepatch: 'test_klp_state2': completing patching transition
[  158.991184] test_klp_state2: post_patch_callback: vmlinux
[  158.991185] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  158.991186] livepatch: 'test_klp_state2': patching complete
[  159.065518] % rmmod test_klp_state
[  159.130779] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  159.130797] livepatch: 'test_klp_state2': initializing unpatching transition
[  159.130818] test_klp_state2: pre_unpatch_callback: vmlinux
[  159.130819] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  159.130820] livepatch: 'test_klp_state2': starting unpatching transition
[  160.911085] livepatch: 'test_klp_state2': completing unpatching transition
[  160.911224] test_klp_state2: post_unpatch_callback: vmlinux
[  160.911226] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  160.911227] livepatch: 'test_klp_state2': unpatching complete
[  160.948036] % rmmod test_klp_state2
[  161.059424] ===== TEST: compatible cumulative livepatches =====
[  161.062474] % modprobe test_klp_state2
[  161.063931] livepatch: enabling patch 'test_klp_state2'
[  161.063934] livepatch: 'test_klp_state2': initializing patching transition
[  161.063957] test_klp_state2: pre_patch_callback: vmlinux
[  161.063958] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  161.063959] livepatch: 'test_klp_state2': starting patching transition
[  162.671079] livepatch: 'test_klp_state2': completing patching transition
[  162.671184] test_klp_state2: post_patch_callback: vmlinux
[  162.671186] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  162.671188] livepatch: 'test_klp_state2': patching complete
[  162.694355] % modprobe test_klp_state3
[  162.695852] livepatch: enabling patch 'test_klp_state3'
[  162.695855] livepatch: 'test_klp_state3': initializing patching transition
[  162.695877] test_klp_state3: pre_patch_callback: vmlinux
[  162.695878] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  162.695879] livepatch: 'test_klp_state3': starting patching transition
[  163.951036] livepatch: 'test_klp_state3': completing patching transition
[  163.951139] test_klp_state3: post_patch_callback: vmlinux
[  163.951141] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  163.951142] livepatch: 'test_klp_state3': patching complete
[  164.019372] % rmmod test_klp_state2
[  164.093821] % modprobe test_klp_state2
[  164.095460] livepatch: enabling patch 'test_klp_state2'
[  164.095463] livepatch: 'test_klp_state2': initializing patching transition
[  164.095484] test_klp_state2: pre_patch_callback: vmlinux
[  164.095485] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  164.095487] livepatch: 'test_klp_state2': starting patching transition
[  165.871122] livepatch: 'test_klp_state2': completing patching transition
[  165.871280] test_klp_state2: post_patch_callback: vmlinux
[  165.871281] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  165.871283] livepatch: 'test_klp_state2': patching complete
[  165.926447] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  165.926486] livepatch: 'test_klp_state2': initializing unpatching transition
[  165.926507] test_klp_state2: pre_unpatch_callback: vmlinux
[  165.926508] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  165.926509] livepatch: 'test_klp_state2': starting unpatching transition
[  166.831076] livepatch: 'test_klp_state2': completing unpatching transition
[  166.831199] test_klp_state2: post_unpatch_callback: vmlinux
[  166.831201] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  166.831203] livepatch: 'test_klp_state2': unpatching complete
[  166.835243] % rmmod test_klp_state2
[  166.901777] % rmmod test_klp_state3
[  166.969742] ===== TEST: incompatible cumulative livepatches =====
[  166.972899] % modprobe test_klp_state2
[  166.974399] livepatch: enabling patch 'test_klp_state2'
[  166.974401] livepatch: 'test_klp_state2': initializing patching transition
[  166.974420] test_klp_state2: pre_patch_callback: vmlinux
[  166.974422] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  166.974423] livepatch: 'test_klp_state2': starting patching transition
[  168.681063] livepatch: 'test_klp_state2': completing patching transition
[  168.681165] test_klp_state2: post_patch_callback: vmlinux
[  168.681167] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  168.681169] livepatch: 'test_klp_state2': patching complete
[  168.703685] % modprobe test_klp_state
[  168.705124] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  168.860784] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  168.860833] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  168.860851] livepatch: 'test_klp_state2': initializing unpatching transition
[  168.860909] test_klp_state2: pre_unpatch_callback: vmlinux
[  168.860910] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  168.860911] livepatch: 'test_klp_state2': starting unpatching transition
[  169.871047] livepatch: 'test_klp_state2': completing unpatching transition
[  169.871186] test_klp_state2: post_unpatch_callback: vmlinux
[  169.871188] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  169.871189] livepatch: 'test_klp_state2': unpatching complete
[  169.971989] % rmmod test_klp_state2
[  170.114423] livepatch: kernel.ftrace_enabled = 1
[  170.122713] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  170.124491] livepatch: kernel.ftrace_enabled = 0
[  170.124552] % modprobe test_klp_livepatch
[  170.125916] livepatch: enabling patch 'test_klp_livepatch'
[  170.125918] livepatch: 'test_klp_livepatch': initializing patching transition
[  170.125942] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  170.125945] livepatch: failed to patch object 'vmlinux'
[  170.125946] livepatch: failed to enable patch 'test_klp_livepatch'
[  170.125947] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  170.125948] livepatch: 'test_klp_livepatch': completing unpatching transition
[  170.126056] livepatch: 'test_klp_livepatch': unpatching complete
[  170.260823] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  170.262584] livepatch: kernel.ftrace_enabled = 1
[  170.265470] % modprobe test_klp_livepatch
[  170.266711] livepatch: enabling patch 'test_klp_livepatch'
[  170.266712] livepatch: 'test_klp_livepatch': initializing patching transition
[  170.267782] livepatch: 'test_klp_livepatch': starting patching transition
[  171.791076] livepatch: 'test_klp_livepatch': completing patching transition
[  171.791226] livepatch: 'test_klp_livepatch': patching complete
[  171.797053] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  171.798001] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  171.798020] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  171.798035] livepatch: 'test_klp_livepatch': starting unpatching transition
[  172.831042] livepatch: 'test_klp_livepatch': completing unpatching transition
[  172.832563] livepatch: 'test_klp_livepatch': unpatching complete
[  172.908336] % rmmod test_klp_livepatch
[  172.983414] livepatch: kernel.ftrace_enabled = 1
[  172.991780] ===== TEST: sysfs test =====
[  172.994796] % modprobe test_klp_livepatch
[  172.996248] livepatch: enabling patch 'test_klp_livepatch'
[  172.996250] livepatch: 'test_klp_livepatch': initializing patching transition
[  172.997482] livepatch: 'test_klp_livepatch': starting patching transition
[  174.671056] livepatch: 'test_klp_livepatch': completing patching transition
[  174.671194] livepatch: 'test_klp_livepatch': patching complete
[  174.734417] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  174.734432] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  174.734466] livepatch: 'test_klp_livepatch': starting unpatching transition
[  175.711081] livepatch: 'test_klp_livepatch': completing unpatching transition
[  175.712575] livepatch: 'test_klp_livepatch': unpatching complete
[  175.744085] % rmmod test_klp_livepatch
[  175.808160] ===== TEST: sysfs test object/patched =====
[  175.810980] % modprobe test_klp_callbacks_demo
[  175.812208] livepatch: enabling patch 'test_klp_callbacks_demo'
[  175.812210] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  175.812230] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  175.812231] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  176.911051] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  176.911161] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  176.911163] livepatch: 'test_klp_callbacks_demo': patching complete
[  176.934731] % modprobe test_klp_callbacks_mod
[  176.935992] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  176.935994] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  176.935996] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  176.936013] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  176.937945] % rmmod test_klp_callbacks_mod
[  176.938946] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  176.938961] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  176.938963] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  176.938964] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  176.991789] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  176.991808] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  176.991828] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  176.991830] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  178.191025] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  178.191124] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  178.191126] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  178.202777] % rmmod test_klp_callbacks_demo
[  178.318263] livepatch: kernel.ftrace_enabled = 1
[  178.326039] ===== TEST: basic function patching =====
[  178.328835] % modprobe test_klp_livepatch
[  178.330156] livepatch: enabling patch 'test_klp_livepatch'
[  178.330158] livepatch: 'test_klp_livepatch': initializing patching transition
[  178.331256] livepatch: 'test_klp_livepatch': starting patching transition
[  179.711061] livepatch: 'test_klp_livepatch': completing patching transition
[  179.711168] livepatch: 'test_klp_livepatch': patching complete
[  179.757176] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  179.757196] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  179.757219] livepatch: 'test_klp_livepatch': starting unpatching transition
[  180.751089] livepatch: 'test_klp_livepatch': completing unpatching transition
[  180.752537] livepatch: 'test_klp_livepatch': unpatching complete
[  180.767212] % rmmod test_klp_livepatch
[  180.830459] ===== TEST: multiple livepatches =====
[  180.833537] % modprobe test_klp_livepatch
[  180.834932] livepatch: enabling patch 'test_klp_livepatch'
[  180.834933] livepatch: 'test_klp_livepatch': initializing patching transition
[  180.836072] livepatch: 'test_klp_livepatch': starting patching transition
[  181.711030] livepatch: 'test_klp_livepatch': completing patching transition
[  181.711129] livepatch: 'test_klp_livepatch': patching complete
[  181.753931] test_klp_livepatch: this has been live patched
[  181.758075] % modprobe test_klp_atomic_replace replace=0
[  181.759630] livepatch: enabling patch 'test_klp_atomic_replace'
[  181.759632] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  181.760761] livepatch: 'test_klp_atomic_replace': starting patching transition
[  182.751097] livepatch: 'test_klp_atomic_replace': completing patching transition
[  182.751210] livepatch: 'test_klp_atomic_replace': patching complete
[  182.779987] test_klp_livepatch: this has been live patched
[  182.780949] test_klp_atomic_replace: this has been live patched
[  182.781132] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  182.781152] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  182.781172] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  183.711178] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  183.712627] livepatch: 'test_klp_atomic_replace': unpatching complete
[  183.791173] % rmmod test_klp_atomic_replace
[  183.881579] test_klp_livepatch: this has been live patched
[  183.882598] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  183.882616] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  183.882634] livepatch: 'test_klp_livepatch': starting unpatching transition
[  184.751183] livepatch: 'test_klp_livepatch': completing unpatching transition
[  184.752715] livepatch: 'test_klp_livepatch': unpatching complete
[  184.791884] % rmmod test_klp_livepatch
[  184.921013] ===== TEST: atomic replace livepatch =====
[  184.924117] % modprobe test_klp_livepatch
[  184.925507] livepatch: enabling patch 'test_klp_livepatch'
[  184.925509] livepatch: 'test_klp_livepatch': initializing patching transition
[  184.926666] livepatch: 'test_klp_livepatch': starting patching transition
[  185.791155] livepatch: 'test_klp_livepatch': completing patching transition
[  185.791263] livepatch: 'test_klp_livepatch': patching complete
[  185.844460] test_klp_livepatch: this has been live patched
[  185.848202] % modprobe test_klp_atomic_replace replace=1
[  185.849784] livepatch: enabling patch 'test_klp_atomic_replace'
[  185.849786] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  185.850899] livepatch: 'test_klp_atomic_replace': starting patching transition
[  186.751268] livepatch: 'test_klp_atomic_replace': completing patching transition
[  186.752724] livepatch: 'test_klp_atomic_replace': patching complete
[  186.769820] test_klp_atomic_replace: this has been live patched
[  186.771001] % rmmod test_klp_livepatch
[  186.842577] test_klp_atomic_replace: this has been live patched
[  186.842713] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  186.842732] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  186.842752] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  187.711155] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  187.712686] livepatch: 'test_klp_atomic_replace': unpatching complete
[  187.751949] % rmmod test_klp_atomic_replace
[  187.875356] livepatch: kernel.ftrace_enabled = 1
[  187.883440] ===== TEST: target module before livepatch =====
[  187.886603] % modprobe test_klp_callbacks_mod
[  187.887986] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  187.891200] % modprobe test_klp_callbacks_demo
[  187.892630] livepatch: enabling patch 'test_klp_callbacks_demo'
[  187.892632] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  187.892658] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  187.892659] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  187.892660] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  189.071175] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  189.071347] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  189.071350] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  189.071351] livepatch: 'test_klp_callbacks_demo': patching complete
[  189.113416] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  189.113437] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  189.113459] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  189.113460] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  189.113461] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  190.831161] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  190.831300] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  190.831303] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  190.831304] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  190.928590] % rmmod test_klp_callbacks_demo
[  190.981743] % rmmod test_klp_callbacks_mod
[  190.982844] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  191.068717] ===== TEST: module_coming notifier =====
[  191.071881] % modprobe test_klp_callbacks_demo
[  191.073324] livepatch: enabling patch 'test_klp_callbacks_demo'
[  191.073326] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  191.073345] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  191.073347] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  192.761063] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  192.761166] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  192.761168] livepatch: 'test_klp_callbacks_demo': patching complete
[  192.804600] % modprobe test_klp_callbacks_mod
[  192.806035] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  192.806038] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  192.806040] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  192.806058] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  192.806411] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  192.806429] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  192.806450] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  192.806452] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  192.806453] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  193.951153] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  193.951254] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  193.951256] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  193.951257] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  194.016717] % rmmod test_klp_callbacks_demo
[  194.111640] % rmmod test_klp_callbacks_mod
[  194.112834] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  194.179536] ===== TEST: module_going notifier =====
[  194.182529] % modprobe test_klp_callbacks_mod
[  194.183902] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  194.186979] % modprobe test_klp_callbacks_demo
[  194.188306] livepatch: enabling patch 'test_klp_callbacks_demo'
[  194.188308] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  194.188334] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  194.188336] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  194.188337] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  195.871146] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  195.871247] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  195.871248] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  195.871250] livepatch: 'test_klp_callbacks_demo': patching complete
[  195.917690] % rmmod test_klp_callbacks_mod
[  195.918839] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  195.918874] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  195.918876] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  195.918877] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  196.000811] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  196.000829] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  196.000847] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  196.000848] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  196.831134] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  196.831258] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  196.831276] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  196.909237] % rmmod test_klp_callbacks_demo
[  196.999252] ===== TEST: module_coming and module_going notifiers =====
[  197.002219] % modprobe test_klp_callbacks_demo
[  197.003720] livepatch: enabling patch 'test_klp_callbacks_demo'
[  197.003722] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  197.003761] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  197.003762] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  197.951097] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  197.951197] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  197.951199] livepatch: 'test_klp_callbacks_demo': patching complete
[  198.023498] % modprobe test_klp_callbacks_mod
[  198.024865] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  198.024868] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  198.024870] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  198.024887] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  198.026043] % rmmod test_klp_callbacks_mod
[  198.027153] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  198.027169] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  198.027171] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  198.027172] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  198.110789] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  198.110807] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  198.110828] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  198.110830] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  199.881138] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  199.881237] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  199.881239] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  199.925505] % rmmod test_klp_callbacks_demo
[  199.999151] ===== TEST: target module not present =====
[  200.002145] % modprobe test_klp_callbacks_demo
[  200.003699] livepatch: enabling patch 'test_klp_callbacks_demo'
[  200.003701] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  200.003721] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  200.003723] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  200.911124] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  200.911242] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  200.911244] livepatch: 'test_klp_callbacks_demo': patching complete
[  200.919249] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  200.919267] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  200.919288] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  200.919289] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  201.951160] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  201.951277] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  201.951279] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  202.028867] % rmmod test_klp_callbacks_demo
[  202.119054] ===== TEST: pre-patch callback -ENODEV =====
[  202.122040] % modprobe test_klp_callbacks_mod
[  202.123508] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  202.123862] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  202.125317] livepatch: enabling patch 'test_klp_callbacks_demo'
[  202.125319] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  202.125341] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  202.125342] livepatch: pre-patch callback failed for object 'vmlinux'
[  202.125343] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  202.125344] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  202.125345] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  202.125496] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  202.250789] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  202.251582] % rmmod test_klp_callbacks_mod
[  202.252724] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  202.348771] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  202.351804] % modprobe test_klp_callbacks_demo
[  202.353355] livepatch: enabling patch 'test_klp_callbacks_demo'
[  202.353357] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  202.353392] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  202.353393] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  203.951197] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  203.951351] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  203.951353] livepatch: 'test_klp_callbacks_demo': patching complete
[  203.979670] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  203.980548] % modprobe test_klp_callbacks_mod
[  203.981920] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  203.981922] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  203.981924] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  203.981925] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  204.130800] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  204.130845] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  204.130862] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  204.130882] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  204.130884] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  205.951235] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  205.951341] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  205.951343] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  206.046975] % rmmod test_klp_callbacks_demo
[  206.128457] ===== TEST: multiple target modules =====
[  206.131336] % modprobe test_klp_callbacks_busy block_transition=N
[  206.132672] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  206.132677] test_klp_callbacks_busy: busymod_work_func enter
[  206.132679] test_klp_callbacks_busy: busymod_work_func exit
[  206.135860] % modprobe test_klp_callbacks_demo
[  206.137206] livepatch: enabling patch 'test_klp_callbacks_demo'
[  206.137207] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  206.137228] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  206.137229] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  206.138577] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  207.871214] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  207.871314] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  207.871316] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  207.871318] livepatch: 'test_klp_callbacks_demo': patching complete
[  207.969934] % modprobe test_klp_callbacks_mod
[  207.971401] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  207.971404] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  207.971406] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  207.971423] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  207.972674] % rmmod test_klp_callbacks_mod
[  207.973849] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  207.973866] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  207.973868] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  207.973870] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  208.050976] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  208.050996] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  208.051017] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  208.051018] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  208.051020] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  208.911216] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  208.912965] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  208.912967] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  208.912969] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  208.959486] % rmmod test_klp_callbacks_demo
[  209.071781] % rmmod test_klp_callbacks_busy
[  209.072943] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  209.149873] ===== TEST: busy target module =====
[  209.152833] % modprobe test_klp_callbacks_busy block_transition=Y
[  209.154258] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  209.154262] test_klp_callbacks_busy: busymod_work_func enter
[  209.157628] % modprobe test_klp_callbacks_demo
[  209.159018] livepatch: enabling patch 'test_klp_callbacks_demo'
[  209.159020] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  209.159040] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  209.159041] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  209.160430] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  209.165518] % modprobe test_klp_callbacks_mod
[  209.166893] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  209.166896] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  209.166914] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  209.168092] % rmmod test_klp_callbacks_mod
[  209.169182] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  209.169198] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  209.169200] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  209.250960] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  209.250978] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  209.251083] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  211.871203] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  211.872965] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  211.872967] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  211.872969] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  211.971835] % rmmod test_klp_callbacks_demo
[  212.051698] % rmmod test_klp_callbacks_busy
[  212.090506] test_klp_callbacks_busy: busymod_work_func exit
[  212.090513] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  212.169096] ===== TEST: multiple livepatches =====
[  212.172221] % modprobe test_klp_callbacks_demo
[  212.173625] livepatch: enabling patch 'test_klp_callbacks_demo'
[  212.173627] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  212.173645] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  212.173646] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  213.881119] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  213.881238] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  213.881240] livepatch: 'test_klp_callbacks_demo': patching complete
[  213.904735] % modprobe test_klp_callbacks_demo2
[  213.906252] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  213.906254] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  213.906291] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  213.906292] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  214.911228] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  214.911330] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  214.911332] livepatch: 'test_klp_callbacks_demo2': patching complete
[  214.923290] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  214.923309] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  214.923323] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  214.923324] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  215.951189] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  215.951289] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  215.951291] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  216.032305] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  216.032322] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  216.032338] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  216.032339] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  216.911208] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  216.911327] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  216.911329] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  216.941200] % rmmod test_klp_callbacks_demo2
[  217.011815] % rmmod test_klp_callbacks_demo
[  217.089875] ===== TEST: atomic replace =====
[  217.092945] % modprobe test_klp_callbacks_demo
[  217.094433] livepatch: enabling patch 'test_klp_callbacks_demo'
[  217.094436] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  217.094455] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  217.094457] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  217.951266] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  217.951371] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  217.951372] livepatch: 'test_klp_callbacks_demo': patching complete
[  218.014048] % modprobe test_klp_callbacks_demo2 replace=1
[  218.015488] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  218.015491] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  218.015512] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  218.015514] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  219.631259] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  219.631381] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  219.631383] livepatch: 'test_klp_callbacks_demo2': patching complete
[  219.643212] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  219.643241] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  219.643273] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  219.643274] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  220.831217] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  220.831316] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  220.831318] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  220.853623] % rmmod test_klp_callbacks_demo2
[  220.931690] % rmmod test_klp_callbacks_demo
[  221.032866] livepatch: kernel.ftrace_enabled = 1
[  221.041249] ===== TEST: basic shadow variable API =====
[  221.044342] % modprobe test_klp_shadow_vars
[  221.046005] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  221.046008] test_klp_shadow_vars:   got expected NULL result
[  221.046010] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  221.046011] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  221.046015] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  221.046016] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  221.046019] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  221.046020] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  221.046022] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  221.046024] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  221.046026] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  221.046028] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  221.046030] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  221.046031] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  221.046034] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  221.046035] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  221.046036] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  221.046038] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  221.046039] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  221.046041] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  221.046042] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  221.046043] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  221.046045] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  221.046046] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  221.046047] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  221.046049] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  221.046050] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  221.046052] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  221.046054] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  221.046056] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  221.046057] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  221.046059] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  221.046061] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  221.046063] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  221.046064] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  221.046066] test_klp_shadow_vars:   got expected NULL result
[  221.046067] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  221.046068] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  221.046070] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  221.046071] test_klp_shadow_vars:   got expected NULL result
[  221.046072] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  221.046073] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  221.046075] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  221.046076] test_klp_shadow_vars:   got expected NULL result
[  221.046077] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  221.046079] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  221.046080] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  221.046081] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  221.046083] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  221.046084] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  221.046092] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  221.046093] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  221.046094] test_klp_shadow_vars:   got expected NULL result
[  221.046095] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  221.046097] test_klp_shadow_vars:   got expected NULL result
[  221.046098] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  221.046099] test_klp_shadow_vars:   got expected NULL result
[  221.047460] % rmmod test_klp_shadow_vars
[  221.132199] livepatch: kernel.ftrace_enabled = 1
[  221.140198] ===== TEST: system state modification =====
[  221.143166] % modprobe test_klp_state
[  221.144614] livepatch: enabling patch 'test_klp_state'
[  221.144616] livepatch: 'test_klp_state': initializing patching transition
[  221.144637] test_klp_state: pre_patch_callback: vmlinux
[  221.144638] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  221.144639] livepatch: 'test_klp_state': starting patching transition
[  222.111272] livepatch: 'test_klp_state': completing patching transition
[  222.111377] test_klp_state: post_patch_callback: vmlinux
[  222.111379] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  222.111381] livepatch: 'test_klp_state': patching complete
[  222.162434] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  222.162453] livepatch: 'test_klp_state': initializing unpatching transition
[  222.162474] test_klp_state: pre_unpatch_callback: vmlinux
[  222.162476] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  222.162477] livepatch: 'test_klp_state': starting unpatching transition
[  223.951243] livepatch: 'test_klp_state': completing unpatching transition
[  223.951343] test_klp_state: post_unpatch_callback: vmlinux
[  223.951345] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  223.951346] livepatch: 'test_klp_state': unpatching complete
[  223.978524] % rmmod test_klp_state
[  224.049861] ===== TEST: taking over system state modification =====
[  224.052982] % modprobe test_klp_state
[  224.054535] livepatch: enabling patch 'test_klp_state'
[  224.054537] livepatch: 'test_klp_state': initializing patching transition
[  224.054558] test_klp_state: pre_patch_callback: vmlinux
[  224.054559] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  224.054561] livepatch: 'test_klp_state': starting patching transition
[  224.921252] livepatch: 'test_klp_state': completing patching transition
[  224.921353] test_klp_state: post_patch_callback: vmlinux
[  224.921355] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  224.921357] livepatch: 'test_klp_state': patching complete
[  224.974637] % modprobe test_klp_state2
[  224.976246] livepatch: enabling patch 'test_klp_state2'
[  224.976248] livepatch: 'test_klp_state2': initializing patching transition
[  224.976275] test_klp_state2: pre_patch_callback: vmlinux
[  224.976276] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  224.976278] livepatch: 'test_klp_state2': starting patching transition
[  226.031256] livepatch: 'test_klp_state2': completing patching transition
[  226.031388] test_klp_state2: post_patch_callback: vmlinux
[  226.031389] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  226.031390] livepatch: 'test_klp_state2': patching complete
[  226.097150] % rmmod test_klp_state
[  226.170953] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  226.170972] livepatch: 'test_klp_state2': initializing unpatching transition
[  226.170994] test_klp_state2: pre_unpatch_callback: vmlinux
[  226.170995] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  226.170996] livepatch: 'test_klp_state2': starting unpatching transition
[  227.951209] livepatch: 'test_klp_state2': completing unpatching transition
[  227.951314] test_klp_state2: post_unpatch_callback: vmlinux
[  227.951317] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  227.951318] livepatch: 'test_klp_state2': unpatching complete
[  227.987229] % rmmod test_klp_state2
[  228.048401] ===== TEST: compatible cumulative livepatches =====
[  228.051472] % modprobe test_klp_state2
[  228.052836] livepatch: enabling patch 'test_klp_state2'
[  228.052839] livepatch: 'test_klp_state2': initializing patching transition
[  228.052858] test_klp_state2: pre_patch_callback: vmlinux
[  228.052860] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  228.052861] livepatch: 'test_klp_state2': starting patching transition
[  229.071292] livepatch: 'test_klp_state2': completing patching transition
[  229.071407] test_klp_state2: post_patch_callback: vmlinux
[  229.071409] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  229.071410] livepatch: 'test_klp_state2': patching complete
[  229.174501] % modprobe test_klp_state3
[  229.175964] livepatch: enabling patch 'test_klp_state3'
[  229.175966] livepatch: 'test_klp_state3': initializing patching transition
[  229.175984] test_klp_state3: pre_patch_callback: vmlinux
[  229.175985] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  229.175986] livepatch: 'test_klp_state3': starting patching transition
[  230.031287] livepatch: 'test_klp_state3': completing patching transition
[  230.031407] test_klp_state3: post_patch_callback: vmlinux
[  230.031409] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  230.031410] livepatch: 'test_klp_state3': patching complete
[  230.092633] % rmmod test_klp_state2
[  230.174017] % modprobe test_klp_state2
[  230.175415] livepatch: enabling patch 'test_klp_state2'
[  230.175416] livepatch: 'test_klp_state2': initializing patching transition
[  230.175437] test_klp_state2: pre_patch_callback: vmlinux
[  230.175438] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  230.175453] livepatch: 'test_klp_state2': starting patching transition
[  231.871289] livepatch: 'test_klp_state2': completing patching transition
[  231.871392] test_klp_state2: post_patch_callback: vmlinux
[  231.871393] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  231.871394] livepatch: 'test_klp_state2': patching complete
[  231.902873] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  231.902893] livepatch: 'test_klp_state2': initializing unpatching transition
[  231.902909] test_klp_state2: pre_unpatch_callback: vmlinux
[  231.902910] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  231.902911] livepatch: 'test_klp_state2': starting unpatching transition
[  232.831270] livepatch: 'test_klp_state2': completing unpatching transition
[  232.831371] test_klp_state2: post_unpatch_callback: vmlinux
[  232.831373] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  232.831374] livepatch: 'test_klp_state2': unpatching complete
[  232.912312] % rmmod test_klp_state2
[  232.961704] % rmmod test_klp_state3
[  233.039460] ===== TEST: incompatible cumulative livepatches =====
[  233.042189] % modprobe test_klp_state2
[  233.043520] livepatch: enabling patch 'test_klp_state2'
[  233.043522] livepatch: 'test_klp_state2': initializing patching transition
[  233.043542] test_klp_state2: pre_patch_callback: vmlinux
[  233.043543] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  233.043545] livepatch: 'test_klp_state2': starting patching transition
[  234.191241] livepatch: 'test_klp_state2': completing patching transition
[  234.191348] test_klp_state2: post_patch_callback: vmlinux
[  234.191365] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  234.191368] livepatch: 'test_klp_state2': patching complete
[  234.263631] % modprobe test_klp_state
[  234.265068] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  234.380932] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  234.380979] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  234.380997] livepatch: 'test_klp_state2': initializing unpatching transition
[  234.381018] test_klp_state2: pre_unpatch_callback: vmlinux
[  234.381019] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  234.381020] livepatch: 'test_klp_state2': starting unpatching transition
[  235.951273] livepatch: 'test_klp_state2': completing unpatching transition
[  235.951373] test_klp_state2: post_unpatch_callback: vmlinux
[  235.951375] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  235.951376] livepatch: 'test_klp_state2': unpatching complete
[  235.994953] % rmmod test_klp_state2
[  236.093180] livepatch: kernel.ftrace_enabled = 1
[  236.101310] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  236.102950] livepatch: kernel.ftrace_enabled = 0
[  236.103030] % modprobe test_klp_livepatch
[  236.104411] livepatch: enabling patch 'test_klp_livepatch'
[  236.104414] livepatch: 'test_klp_livepatch': initializing patching transition
[  236.104437] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  236.104439] livepatch: failed to patch object 'vmlinux'
[  236.104440] livepatch: failed to enable patch 'test_klp_livepatch'
[  236.104441] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  236.104442] livepatch: 'test_klp_livepatch': completing unpatching transition
[  236.104560] livepatch: 'test_klp_livepatch': unpatching complete
[  236.260929] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  236.262507] livepatch: kernel.ftrace_enabled = 1
[  236.265215] % modprobe test_klp_livepatch
[  236.266486] livepatch: enabling patch 'test_klp_livepatch'
[  236.266488] livepatch: 'test_klp_livepatch': initializing patching transition
[  236.267596] livepatch: 'test_klp_livepatch': starting patching transition
[  237.791212] livepatch: 'test_klp_livepatch': completing patching transition
[  237.791310] livepatch: 'test_klp_livepatch': patching complete
[  237.797154] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  237.798043] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  237.798095] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  237.798109] livepatch: 'test_klp_livepatch': starting unpatching transition
[  238.831322] livepatch: 'test_klp_livepatch': completing unpatching transition
[  238.832826] livepatch: 'test_klp_livepatch': unpatching complete
[  238.908640] % rmmod test_klp_livepatch
[  238.992263] livepatch: kernel.ftrace_enabled = 1
[  238.999933] ===== TEST: sysfs test =====
[  239.002807] % modprobe test_klp_livepatch
[  239.004110] livepatch: enabling patch 'test_klp_livepatch'
[  239.004111] livepatch: 'test_klp_livepatch': initializing patching transition
[  239.005181] livepatch: 'test_klp_livepatch': starting patching transition
[  240.111262] livepatch: 'test_klp_livepatch': completing patching transition
[  240.111381] livepatch: 'test_klp_livepatch': patching complete
[  240.132783] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  240.132799] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  240.132815] livepatch: 'test_klp_livepatch': starting unpatching transition
[  241.081328] livepatch: 'test_klp_livepatch': completing unpatching transition
[  241.082831] livepatch: 'test_klp_livepatch': unpatching complete
[  241.142598] % rmmod test_klp_livepatch
[  241.210158] ===== TEST: sysfs test object/patched =====
[  241.213283] % modprobe test_klp_callbacks_demo
[  241.214762] livepatch: enabling patch 'test_klp_callbacks_demo'
[  241.214764] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  241.214784] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  241.214785] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  242.031320] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  242.031449] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  242.031451] livepatch: 'test_klp_callbacks_demo': patching complete
[  242.136182] % modprobe test_klp_callbacks_mod
[  242.137515] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  242.137517] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  242.137519] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  242.137535] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  242.139783] % rmmod test_klp_callbacks_mod
[  242.140942] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  242.140957] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  242.140959] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  242.140960] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  242.231991] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  242.232011] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  242.232030] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  242.232032] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  243.071322] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  243.071422] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  243.071424] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  243.141124] % rmmod test_klp_callbacks_demo
[  243.282256] livepatch: kernel.ftrace_enabled = 1
[  243.290569] ===== TEST: basic function patching =====
[  243.293596] % modprobe test_klp_livepatch
[  243.295013] livepatch: enabling patch 'test_klp_livepatch'
[  243.295016] livepatch: 'test_klp_livepatch': initializing patching transition
[  243.296162] livepatch: 'test_klp_livepatch': starting patching transition
[  244.911383] livepatch: 'test_klp_livepatch': completing patching transition
[  244.911489] livepatch: 'test_klp_livepatch': patching complete
[  244.924091] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  244.924112] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  244.924134] livepatch: 'test_klp_livepatch': starting unpatching transition
[  245.871319] livepatch: 'test_klp_livepatch': completing unpatching transition
[  245.872799] livepatch: 'test_klp_livepatch': unpatching complete
[  245.934000] % rmmod test_klp_livepatch
[  246.029530] ===== TEST: multiple livepatches =====
[  246.032436] % modprobe test_klp_livepatch
[  246.033861] livepatch: enabling patch 'test_klp_livepatch'
[  246.033863] livepatch: 'test_klp_livepatch': initializing patching transition
[  246.034968] livepatch: 'test_klp_livepatch': starting patching transition
[  247.711339] livepatch: 'test_klp_livepatch': completing patching transition
[  247.711489] livepatch: 'test_klp_livepatch': patching complete
[  247.763427] test_klp_livepatch: this has been live patched
[  247.767396] % modprobe test_klp_atomic_replace replace=0
[  247.768853] livepatch: enabling patch 'test_klp_atomic_replace'
[  247.768854] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  247.769960] livepatch: 'test_klp_atomic_replace': starting patching transition
[  248.751335] livepatch: 'test_klp_atomic_replace': completing patching transition
[  248.751471] livepatch: 'test_klp_atomic_replace': patching complete
[  248.788134] test_klp_livepatch: this has been live patched
[  248.789014] test_klp_atomic_replace: this has been live patched
[  248.789161] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  248.789181] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  248.789197] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  249.711272] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  249.712588] livepatch: 'test_klp_atomic_replace': unpatching complete
[  249.798070] % rmmod test_klp_atomic_replace
[  249.851728] test_klp_livepatch: this has been live patched
[  249.852707] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  249.852727] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  249.852745] livepatch: 'test_klp_livepatch': starting unpatching transition
[  250.751345] livepatch: 'test_klp_livepatch': completing unpatching transition
[  250.752836] livepatch: 'test_klp_livepatch': unpatching complete
[  250.761513] % rmmod test_klp_livepatch
[  250.851360] ===== TEST: atomic replace livepatch =====
[  250.854431] % modprobe test_klp_livepatch
[  250.855791] livepatch: enabling patch 'test_klp_livepatch'
[  250.855793] livepatch: 'test_klp_livepatch': initializing patching transition
[  250.856996] livepatch: 'test_klp_livepatch': starting patching transition
[  251.711343] livepatch: 'test_klp_livepatch': completing patching transition
[  251.711461] livepatch: 'test_klp_livepatch': patching complete
[  251.773219] test_klp_livepatch: this has been live patched
[  251.777357] % modprobe test_klp_atomic_replace replace=1
[  251.778873] livepatch: enabling patch 'test_klp_atomic_replace'
[  251.778875] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  251.780049] livepatch: 'test_klp_atomic_replace': starting patching transition
[  252.911301] livepatch: 'test_klp_atomic_replace': completing patching transition
[  252.912669] livepatch: 'test_klp_atomic_replace': patching complete
[  253.001881] test_klp_atomic_replace: this has been live patched
[  253.002864] % rmmod test_klp_livepatch
[  253.052447] test_klp_atomic_replace: this has been live patched
[  253.052561] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  253.052580] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  253.052597] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  253.871341] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  253.872934] livepatch: 'test_klp_atomic_replace': unpatching complete
[  253.961071] % rmmod test_klp_atomic_replace
[  254.075347] livepatch: kernel.ftrace_enabled = 1
[  254.083375] ===== TEST: target module before livepatch =====
[  254.086470] % modprobe test_klp_callbacks_mod
[  254.087750] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  254.091112] % modprobe test_klp_callbacks_demo
[  254.092572] livepatch: enabling patch 'test_klp_callbacks_demo'
[  254.092574] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  254.092593] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  254.092594] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  254.092595] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  254.911372] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  254.911470] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  254.911472] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  254.911474] livepatch: 'test_klp_callbacks_demo': patching complete
[  255.008950] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  255.008969] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  255.009000] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  255.009002] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  255.009020] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  255.951355] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  255.951452] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  255.951454] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  255.951456] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  256.018607] % rmmod test_klp_callbacks_demo
[  256.091916] % rmmod test_klp_callbacks_mod
[  256.093014] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  256.169237] ===== TEST: module_coming notifier =====
[  256.172297] % modprobe test_klp_callbacks_demo
[  256.173751] livepatch: enabling patch 'test_klp_callbacks_demo'
[  256.173753] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  256.173772] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  256.173774] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  257.871420] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  257.871550] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  257.871552] livepatch: 'test_klp_callbacks_demo': patching complete
[  257.906694] % modprobe test_klp_callbacks_mod
[  257.907956] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  257.907958] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  257.907959] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  257.907977] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  257.908350] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  257.908367] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  257.908387] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  257.908388] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  257.908390] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  258.911396] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  258.911552] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  258.911554] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  258.911556] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  258.918270] % rmmod test_klp_callbacks_demo
[  259.001970] % rmmod test_klp_callbacks_mod
[  259.002953] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  259.118512] ===== TEST: module_going notifier =====
[  259.121469] % modprobe test_klp_callbacks_mod
[  259.122753] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  259.125852] % modprobe test_klp_callbacks_demo
[  259.127258] livepatch: enabling patch 'test_klp_callbacks_demo'
[  259.127259] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  259.127280] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  259.127281] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  259.127282] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  260.191345] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  260.191448] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  260.191449] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  260.191451] livepatch: 'test_klp_callbacks_demo': patching complete
[  260.248083] % rmmod test_klp_callbacks_mod
[  260.249312] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  260.249330] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  260.249332] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  260.249333] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  260.311104] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  260.311123] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  260.311150] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  260.311151] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  261.151436] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  261.151581] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  261.151583] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  261.220008] % rmmod test_klp_callbacks_demo
[  261.309304] ===== TEST: module_coming and module_going notifiers =====
[  261.312251] % modprobe test_klp_callbacks_demo
[  261.313722] livepatch: enabling patch 'test_klp_callbacks_demo'
[  261.313724] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  261.313762] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  261.313763] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  262.671500] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  262.671624] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  262.671626] livepatch: 'test_klp_callbacks_demo': patching complete
[  262.742090] % modprobe test_klp_callbacks_mod
[  262.743321] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  262.743324] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  262.743326] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  262.743344] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  262.744479] % rmmod test_klp_callbacks_mod
[  262.745567] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  262.745582] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  262.745584] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  262.745585] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  262.811091] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  262.811109] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  262.811130] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  262.811131] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  263.951430] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  263.951537] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  263.951539] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  264.022343] % rmmod test_klp_callbacks_demo
[  264.179776] ===== TEST: target module not present =====
[  264.182883] % modprobe test_klp_callbacks_demo
[  264.184345] livepatch: enabling patch 'test_klp_callbacks_demo'
[  264.184347] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  264.184367] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  264.184368] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  265.081369] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  265.081514] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  265.081516] livepatch: 'test_klp_callbacks_demo': patching complete
[  265.101043] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  265.101062] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  265.101083] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  265.101084] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  266.191411] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  266.191510] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  266.191512] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  266.211817] % rmmod test_klp_callbacks_demo
[  266.279575] ===== TEST: pre-patch callback -ENODEV =====
[  266.282491] % modprobe test_klp_callbacks_mod
[  266.283760] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  266.284111] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  266.285525] livepatch: enabling patch 'test_klp_callbacks_demo'
[  266.285527] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  266.285548] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  266.285549] livepatch: pre-patch callback failed for object 'vmlinux'
[  266.285550] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  266.285551] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  266.285552] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  266.285659] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  266.481071] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  266.482054] % rmmod test_klp_callbacks_mod
[  266.483170] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  266.569358] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  266.572523] % modprobe test_klp_callbacks_demo
[  266.573921] livepatch: enabling patch 'test_klp_callbacks_demo'
[  266.573924] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  266.573963] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  266.573965] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  268.031434] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  268.031535] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  268.031537] livepatch: 'test_klp_callbacks_demo': patching complete
[  268.100668] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  268.101662] % modprobe test_klp_callbacks_mod
[  268.102985] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  268.102988] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  268.102990] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  268.102991] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  268.231087] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  268.231141] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  268.231156] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  268.231176] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  268.231177] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  269.951417] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  269.951520] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  269.951522] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  270.048128] % rmmod test_klp_callbacks_demo
[  270.110260] ===== TEST: multiple target modules =====
[  270.113377] % modprobe test_klp_callbacks_busy block_transition=N
[  270.114847] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  270.114851] test_klp_callbacks_busy: busymod_work_func enter
[  270.114853] test_klp_callbacks_busy: busymod_work_func exit
[  270.118456] % modprobe test_klp_callbacks_demo
[  270.119920] livepatch: enabling patch 'test_klp_callbacks_demo'
[  270.119922] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  270.119941] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  270.119943] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  270.121350] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  271.871484] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  271.871585] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  271.871587] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  271.871589] livepatch: 'test_klp_callbacks_demo': patching complete
[  271.957226] % modprobe test_klp_callbacks_mod
[  271.958646] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  271.958665] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  271.958667] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  271.958683] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  271.960010] % rmmod test_klp_callbacks_mod
[  271.961127] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  271.961141] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  271.961143] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  271.961145] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  272.031267] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  272.031285] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  272.031303] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  272.031304] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  272.031306] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  272.831467] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  272.833230] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  272.833232] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  272.833233] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  272.839688] % rmmod test_klp_callbacks_demo
[  272.912113] % rmmod test_klp_callbacks_busy
[  272.913268] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  272.989731] ===== TEST: busy target module =====
[  272.992863] % modprobe test_klp_callbacks_busy block_transition=Y
[  272.994427] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  272.994433] test_klp_callbacks_busy: busymod_work_func enter
[  272.997897] % modprobe test_klp_callbacks_demo
[  272.999390] livepatch: enabling patch 'test_klp_callbacks_demo'
[  272.999391] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  272.999413] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  272.999415] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  273.000863] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  273.006166] % modprobe test_klp_callbacks_mod
[  273.007622] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  273.007624] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  273.007651] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  273.009014] % rmmod test_klp_callbacks_mod
[  273.010123] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  273.010139] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  273.010141] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  273.091251] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  273.091269] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  273.091425] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  275.791451] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  275.793206] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  275.793209] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  275.793210] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  275.815309] % rmmod test_klp_callbacks_demo
[  275.882051] % rmmod test_klp_callbacks_busy
[  275.890764] test_klp_callbacks_busy: busymod_work_func exit
[  275.890773] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  275.959816] ===== TEST: multiple livepatches =====
[  275.963029] % modprobe test_klp_callbacks_demo
[  275.964604] livepatch: enabling patch 'test_klp_callbacks_demo'
[  275.964606] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  275.964628] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  275.964629] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  277.641504] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  277.641611] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  277.641613] livepatch: 'test_klp_callbacks_demo': patching complete
[  277.698468] % modprobe test_klp_callbacks_demo2
[  277.700098] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  277.700100] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  277.700119] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  277.700120] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  278.681475] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  278.681615] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  278.681617] livepatch: 'test_klp_callbacks_demo2': patching complete
[  278.719462] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  278.719482] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  278.719504] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  278.719505] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  279.791389] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  279.791487] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  279.791489] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  279.829592] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  279.829612] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  279.829629] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  279.829630] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  280.831497] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  280.831602] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  280.831604] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  280.839540] % rmmod test_klp_callbacks_demo2
[  280.912127] % rmmod test_klp_callbacks_demo
[  280.989065] ===== TEST: atomic replace =====
[  280.991951] % modprobe test_klp_callbacks_demo
[  280.993414] livepatch: enabling patch 'test_klp_callbacks_demo'
[  280.993416] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  280.993436] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  280.993437] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  281.871479] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  281.871579] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  281.871581] livepatch: 'test_klp_callbacks_demo': patching complete
[  281.912919] % modprobe test_klp_callbacks_demo2 replace=1
[  281.914353] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  281.914356] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  281.914376] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  281.914377] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  283.071478] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  283.071583] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  283.071585] livepatch: 'test_klp_callbacks_demo2': patching complete
[  283.135341] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  283.135361] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  283.135381] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  283.135382] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  284.031462] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  284.031579] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  284.031580] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  284.044328] % rmmod test_klp_callbacks_demo2
[  284.112113] % rmmod test_klp_callbacks_demo
[  284.224335] livepatch: kernel.ftrace_enabled = 1

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg1.txt"

[  100.031067] livepatch: 'test_klp_state2': completing patching transition
[  100.031184] test_klp_state2: post_patch_callback: vmlinux
[  100.031185] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  100.031187] livepatch: 'test_klp_state2': patching complete
[  100.045573] % modprobe test_klp_state3
[  100.047069] livepatch: enabling patch 'test_klp_state3'
[  100.047072] livepatch: 'test_klp_state3': initializing patching transition
[  100.047093] test_klp_state3: pre_patch_callback: vmlinux
[  100.047094] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  100.047095] livepatch: 'test_klp_state3': starting patching transition
[  101.711037] livepatch: 'test_klp_state3': completing patching transition
[  101.711204] test_klp_state3: post_patch_callback: vmlinux
[  101.711206] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  101.711207] livepatch: 'test_klp_state3': patching complete
[  101.778205] % rmmod test_klp_state2
[  101.853923] % modprobe test_klp_state2
[  101.855447] livepatch: enabling patch 'test_klp_state2'
[  101.855449] livepatch: 'test_klp_state2': initializing patching transition
[  101.855470] test_klp_state2: pre_patch_callback: vmlinux
[  101.855472] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  101.855473] livepatch: 'test_klp_state2': starting patching transition
[  103.630965] livepatch: 'test_klp_state2': completing patching transition
[  103.631070] test_klp_state2: post_patch_callback: vmlinux
[  103.631071] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  103.631073] livepatch: 'test_klp_state2': patching complete
[  103.686892] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  103.686911] livepatch: 'test_klp_state2': initializing unpatching transition
[  103.686932] test_klp_state2: pre_unpatch_callback: vmlinux
[  103.686933] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  103.686935] livepatch: 'test_klp_state2': starting unpatching transition
[  105.150996] livepatch: 'test_klp_state2': completing unpatching transition
[  105.151097] test_klp_state2: post_unpatch_callback: vmlinux
[  105.151099] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  105.151100] livepatch: 'test_klp_state2': unpatching complete
[  105.199966] % rmmod test_klp_state2
[  105.281410] % rmmod test_klp_state3
[  105.355459] ===== TEST: incompatible cumulative livepatches =====
[  105.358650] % modprobe test_klp_state2
[  105.360034] livepatch: enabling patch 'test_klp_state2'
[  105.360035] livepatch: 'test_klp_state2': initializing patching transition
[  105.360056] test_klp_state2: pre_patch_callback: vmlinux
[  105.360057] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  105.360058] livepatch: 'test_klp_state2': starting patching transition
[  107.071045] livepatch: 'test_klp_state2': completing patching transition
[  107.071145] test_klp_state2: post_patch_callback: vmlinux
[  107.071147] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  107.071148] livepatch: 'test_klp_state2': patching complete
[  107.087110] % modprobe test_klp_state
[  107.088695] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  107.190677] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  107.190716] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  107.190734] livepatch: 'test_klp_state2': initializing unpatching transition
[  107.190753] test_klp_state2: pre_unpatch_callback: vmlinux
[  107.190754] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  107.190755] livepatch: 'test_klp_state2': starting unpatching transition
[  108.111015] livepatch: 'test_klp_state2': completing unpatching transition
[  108.111118] test_klp_state2: post_unpatch_callback: vmlinux
[  108.111120] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  108.111121] livepatch: 'test_klp_state2': unpatching complete
[  108.200035] % rmmod test_klp_state2
[  108.301787] livepatch: kernel.ftrace_enabled = 1
[  108.308056] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  108.309828] livepatch: kernel.ftrace_enabled = 0
[  108.309890] % modprobe test_klp_livepatch
[  108.311242] livepatch: enabling patch 'test_klp_livepatch'
[  108.311244] livepatch: 'test_klp_livepatch': initializing patching transition
[  108.311267] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  108.311270] livepatch: failed to patch object 'vmlinux'
[  108.311271] livepatch: failed to enable patch 'test_klp_livepatch'
[  108.311272] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  108.311273] livepatch: 'test_klp_livepatch': completing unpatching transition
[  108.311382] livepatch: 'test_klp_livepatch': unpatching complete
[  108.500681] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  108.502529] livepatch: kernel.ftrace_enabled = 1
[  108.505528] % modprobe test_klp_livepatch
[  108.506881] livepatch: enabling patch 'test_klp_livepatch'
[  108.506882] livepatch: 'test_klp_livepatch': initializing patching transition
[  108.508030] livepatch: 'test_klp_livepatch': starting patching transition
[  109.790992] livepatch: 'test_klp_livepatch': completing patching transition
[  109.791146] livepatch: 'test_klp_livepatch': patching complete
[  109.834645] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  109.835658] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  109.835676] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  109.835692] livepatch: 'test_klp_livepatch': starting unpatching transition
[  110.831016] livepatch: 'test_klp_livepatch': completing unpatching transition
[  110.832521] livepatch: 'test_klp_livepatch': unpatching complete
[  110.845082] % rmmod test_klp_livepatch
[  110.962324] livepatch: kernel.ftrace_enabled = 1
[  110.969070] ===== TEST: sysfs test =====
[  110.972147] % modprobe test_klp_livepatch
[  110.973575] livepatch: enabling patch 'test_klp_livepatch'
[  110.973578] livepatch: 'test_klp_livepatch': initializing patching transition
[  110.974676] livepatch: 'test_klp_livepatch': starting patching transition
[  112.671034] livepatch: 'test_klp_livepatch': completing patching transition
[  112.671137] livepatch: 'test_klp_livepatch': patching complete
[  112.711815] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  112.711832] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  112.711853] livepatch: 'test_klp_livepatch': starting unpatching transition
[  113.711046] livepatch: 'test_klp_livepatch': completing unpatching transition
[  113.712556] livepatch: 'test_klp_livepatch': unpatching complete
[  113.721666] % rmmod test_klp_livepatch
[  113.786348] ===== TEST: sysfs test object/patched =====
[  113.789508] % modprobe test_klp_callbacks_demo
[  113.791059] livepatch: enabling patch 'test_klp_callbacks_demo'
[  113.791061] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  113.791082] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  113.791083] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  114.831046] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  114.831155] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  114.831157] livepatch: 'test_klp_callbacks_demo': patching complete
[  114.915700] % modprobe test_klp_callbacks_mod
[  114.917199] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  114.917201] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  114.917203] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  114.917220] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  114.919407] % rmmod test_klp_callbacks_mod
[  114.920563] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  114.920578] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  114.920580] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  114.920582] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  114.991648] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  114.991667] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  114.991690] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  114.991692] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  116.671055] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  116.671159] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  116.671177] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  116.706610] % rmmod test_klp_callbacks_demo
[  116.853345] livepatch: kernel.ftrace_enabled = 1
[  116.860222] ===== TEST: basic function patching =====
[  116.863329] % modprobe test_klp_livepatch
[  116.864936] livepatch: enabling patch 'test_klp_livepatch'
[  116.864938] livepatch: 'test_klp_livepatch': initializing patching transition
[  116.866224] livepatch: 'test_klp_livepatch': starting patching transition
[  117.791071] livepatch: 'test_klp_livepatch': completing patching transition
[  117.791193] livepatch: 'test_klp_livepatch': patching complete
[  117.885360] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  117.885397] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  117.885424] livepatch: 'test_klp_livepatch': starting unpatching transition
[  118.750980] livepatch: 'test_klp_livepatch': completing unpatching transition
[  118.752543] livepatch: 'test_klp_livepatch': unpatching complete
[  118.794530] % rmmod test_klp_livepatch
[  118.897157] ===== TEST: multiple livepatches =====
[  118.900009] % modprobe test_klp_livepatch
[  118.901338] livepatch: enabling patch 'test_klp_livepatch'
[  118.901341] livepatch: 'test_klp_livepatch': initializing patching transition
[  118.902413] livepatch: 'test_klp_livepatch': starting patching transition
[  119.711012] livepatch: 'test_klp_livepatch': completing patching transition
[  119.711114] livepatch: 'test_klp_livepatch': patching complete
[  119.718796] test_klp_livepatch: this has been live patched
[  119.723001] % modprobe test_klp_atomic_replace replace=0
[  119.724612] livepatch: enabling patch 'test_klp_atomic_replace'
[  119.724614] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  119.725833] livepatch: 'test_klp_atomic_replace': starting patching transition
[  120.751022] livepatch: 'test_klp_atomic_replace': completing patching transition
[  120.751130] livepatch: 'test_klp_atomic_replace': patching complete
[  120.847005] test_klp_livepatch: this has been live patched
[  120.847986] test_klp_atomic_replace: this has been live patched
[  120.848118] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  120.848138] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  120.848158] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  121.710988] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  121.712378] livepatch: 'test_klp_atomic_replace': unpatching complete
[  121.757104] % rmmod test_klp_atomic_replace
[  121.801514] test_klp_livepatch: this has been live patched
[  121.802520] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  121.802538] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  121.802554] livepatch: 'test_klp_livepatch': starting unpatching transition
[  122.761006] livepatch: 'test_klp_livepatch': completing unpatching transition
[  122.762405] livepatch: 'test_klp_livepatch': unpatching complete
[  122.812386] % rmmod test_klp_livepatch
[  122.888229] ===== TEST: atomic replace livepatch =====
[  122.891365] % modprobe test_klp_livepatch
[  122.892757] livepatch: enabling patch 'test_klp_livepatch'
[  122.892759] livepatch: 'test_klp_livepatch': initializing patching transition
[  122.893900] livepatch: 'test_klp_livepatch': starting patching transition
[  123.871073] livepatch: 'test_klp_livepatch': completing patching transition
[  123.871179] livepatch: 'test_klp_livepatch': patching complete
[  123.913201] test_klp_livepatch: this has been live patched
[  123.917508] % modprobe test_klp_atomic_replace replace=1
[  123.918994] livepatch: enabling patch 'test_klp_atomic_replace'
[  123.918996] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  123.920106] livepatch: 'test_klp_atomic_replace': starting patching transition
[  124.751016] livepatch: 'test_klp_atomic_replace': completing patching transition
[  124.752390] livepatch: 'test_klp_atomic_replace': patching complete
[  124.838483] test_klp_atomic_replace: this has been live patched
[  124.839576] % rmmod test_klp_livepatch
[  124.892319] test_klp_atomic_replace: this has been live patched
[  124.892494] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  124.892513] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  124.892529] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  125.711010] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  125.712510] livepatch: 'test_klp_atomic_replace': unpatching complete
[  125.801651] % rmmod test_klp_atomic_replace
[  125.905407] livepatch: kernel.ftrace_enabled = 1
[  125.912644] ===== TEST: target module before livepatch =====
[  125.915835] % modprobe test_klp_callbacks_mod
[  125.917236] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  125.920790] % modprobe test_klp_callbacks_demo
[  125.922345] livepatch: enabling patch 'test_klp_callbacks_demo'
[  125.922347] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  125.922366] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  125.922367] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  125.922369] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  127.711053] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  127.711189] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  127.711191] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  127.711193] livepatch: 'test_klp_callbacks_demo': patching complete
[  127.755072] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  127.755091] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  127.755106] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  127.755107] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  127.755109] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  128.671068] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  128.671171] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  128.671172] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  128.671174] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  128.765224] % rmmod test_klp_callbacks_demo
[  128.811614] % rmmod test_klp_callbacks_mod
[  128.812787] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  128.887174] ===== TEST: module_coming notifier =====
[  128.890422] % modprobe test_klp_callbacks_demo
[  128.892042] livepatch: enabling patch 'test_klp_callbacks_demo'
[  128.892045] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  128.892067] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  128.892068] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  129.791064] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  129.791173] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  129.791175] livepatch: 'test_klp_callbacks_demo': patching complete
[  129.812482] % modprobe test_klp_callbacks_mod
[  129.813968] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  129.813971] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  129.813973] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  129.813990] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  129.814364] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  129.814383] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  129.814404] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  129.814405] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  129.814407] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  130.671041] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  130.671174] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  130.671176] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  130.671178] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  130.723905] % rmmod test_klp_callbacks_demo
[  130.771625] % rmmod test_klp_callbacks_mod
[  130.772641] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  130.826909] ===== TEST: module_going notifier =====
[  130.830202] % modprobe test_klp_callbacks_mod
[  130.831538] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  130.834984] % modprobe test_klp_callbacks_demo
[  130.836549] livepatch: enabling patch 'test_klp_callbacks_demo'
[  130.836552] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  130.836573] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  130.836574] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  130.836576] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  131.710974] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  131.711075] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  131.711077] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  131.711079] livepatch: 'test_klp_callbacks_demo': patching complete
[  131.754244] % rmmod test_klp_callbacks_mod
[  131.755454] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  131.755471] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  131.755473] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  131.755475] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  131.800736] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  131.800754] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  131.800775] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  131.800776] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  133.071027] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  133.071132] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  133.071134] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  133.113297] % rmmod test_klp_callbacks_demo
[  133.177434] ===== TEST: module_coming and module_going notifiers =====
[  133.180622] % modprobe test_klp_callbacks_demo
[  133.182228] livepatch: enabling patch 'test_klp_callbacks_demo'
[  133.182231] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  133.182251] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  133.182252] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  134.751073] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  134.751184] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  134.751187] livepatch: 'test_klp_callbacks_demo': patching complete
[  134.813811] % modprobe test_klp_callbacks_mod
[  134.815280] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  134.815282] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  134.815284] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  134.815302] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  134.816526] % rmmod test_klp_callbacks_mod
[  134.817758] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  134.817773] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  134.817775] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  134.817776] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  134.940787] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  134.940806] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  134.940828] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  134.940829] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  135.950967] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  135.951069] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  135.951071] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  136.051536] % rmmod test_klp_callbacks_demo
[  136.117597] ===== TEST: target module not present =====
[  136.120836] % modprobe test_klp_callbacks_demo
[  136.122441] livepatch: enabling patch 'test_klp_callbacks_demo'
[  136.122444] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  136.122476] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  136.122477] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  137.871054] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  137.871179] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  137.871181] livepatch: 'test_klp_callbacks_demo': patching complete
[  137.952610] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  137.952631] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  137.952666] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  137.952668] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  139.071051] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  139.071152] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  139.071154] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  139.164250] % rmmod test_klp_callbacks_demo
[  139.257782] ===== TEST: pre-patch callback -ENODEV =====
[  139.260610] % modprobe test_klp_callbacks_mod
[  139.261932] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  139.262266] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  139.263690] livepatch: enabling patch 'test_klp_callbacks_demo'
[  139.263692] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  139.263711] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  139.263712] livepatch: pre-patch callback failed for object 'vmlinux'
[  139.263713] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  139.263714] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  139.263715] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  139.263820] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  139.410666] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  139.411683] % rmmod test_klp_callbacks_mod
[  139.412838] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  139.477858] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  139.480794] % modprobe test_klp_callbacks_demo
[  139.482279] livepatch: enabling patch 'test_klp_callbacks_demo'
[  139.482282] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  139.482303] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  139.482304] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  140.831122] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  140.831279] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  140.831281] livepatch: 'test_klp_callbacks_demo': patching complete
[  140.908032] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  140.908963] % modprobe test_klp_callbacks_mod
[  140.910243] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  140.910246] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  140.910248] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  140.910249] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  141.030671] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  141.030722] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  141.030738] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  141.030776] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  141.030777] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  141.789613] crw_info : CRW reports slct=0, oflw=0, chn=0, rsc=B, anc=0, erc=0, rsid=0
[  142.031077] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  142.031196] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  142.031198] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  142.041387] % rmmod test_klp_callbacks_demo
[  142.108391] ===== TEST: multiple target modules =====
[  142.111495] % modprobe test_klp_callbacks_busy block_transition=N
[  142.112950] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  142.112954] test_klp_callbacks_busy: busymod_work_func enter
[  142.112956] test_klp_callbacks_busy: busymod_work_func exit
[  142.116379] % modprobe test_klp_callbacks_demo
[  142.117801] livepatch: enabling patch 'test_klp_callbacks_demo'
[  142.117802] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  142.117840] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  142.117841] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  142.119215] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  143.070935] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  143.071035] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  143.071037] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  143.071039] livepatch: 'test_klp_callbacks_demo': patching complete
[  143.141657] % modprobe test_klp_callbacks_mod
[  143.143195] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  143.143198] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.143200] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  143.143236] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  143.144563] % rmmod test_klp_callbacks_mod
[  143.145857] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  143.145873] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.145875] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  143.145876] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  143.220815] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  143.220851] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  143.220872] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  143.220873] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  143.220875] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  144.031007] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  144.032819] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  144.032821] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  144.032822] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  144.130433] % rmmod test_klp_callbacks_demo
[  144.211697] % rmmod test_klp_callbacks_busy
[  144.213003] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  144.308603] ===== TEST: busy target module =====
[  144.311786] % modprobe test_klp_callbacks_busy block_transition=Y
[  144.313186] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  144.313190] test_klp_callbacks_busy: busymod_work_func enter
[  144.316644] % modprobe test_klp_callbacks_demo
[  144.318094] livepatch: enabling patch 'test_klp_callbacks_demo'
[  144.318095] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  144.318115] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  144.318116] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  144.319516] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  144.324787] % modprobe test_klp_callbacks_mod
[  144.326157] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  144.326159] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  144.326174] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  144.327454] % rmmod test_klp_callbacks_mod
[  144.328546] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  144.328561] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  144.328563] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  144.410842] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  144.410861] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  144.410966] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  146.990932] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  146.992683] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  146.992685] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  146.992687] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  147.033638] % rmmod test_klp_callbacks_demo
[  147.121645] % rmmod test_klp_callbacks_busy
[  147.130314] test_klp_callbacks_busy: busymod_work_func exit
[  147.130323] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  147.208177] ===== TEST: multiple livepatches =====
[  147.211079] % modprobe test_klp_callbacks_demo
[  147.212707] livepatch: enabling patch 'test_klp_callbacks_demo'
[  147.212710] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  147.212730] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  147.212731] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  148.031059] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  148.031160] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  148.031162] livepatch: 'test_klp_callbacks_demo': patching complete
[  148.132098] % modprobe test_klp_callbacks_demo2
[  148.133641] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  148.133644] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  148.133664] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  148.133666] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  149.151067] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  149.151184] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  149.151186] livepatch: 'test_klp_callbacks_demo2': patching complete
[  149.152975] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  149.152995] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  149.153015] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  149.153016] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  149.951022] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  149.951125] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  149.951127] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  149.960854] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  149.960873] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  149.960888] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  149.960890] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  150.991050] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  150.991152] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  150.991154] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  151.071631] % rmmod test_klp_callbacks_demo2
[  151.131726] % rmmod test_klp_callbacks_demo
[  151.229250] ===== TEST: atomic replace =====
[  151.232455] % modprobe test_klp_callbacks_demo
[  151.234085] livepatch: enabling patch 'test_klp_callbacks_demo'
[  151.234087] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  151.234107] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  151.234108] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  152.031077] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  152.031231] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  152.031233] livepatch: 'test_klp_callbacks_demo': patching complete
[  152.052914] % modprobe test_klp_callbacks_demo2 replace=1
[  152.054593] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  152.054595] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  152.054616] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  152.054618] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  153.071103] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  153.071224] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  153.071226] livepatch: 'test_klp_callbacks_demo2': patching complete
[  153.073798] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  153.073819] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  153.073840] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  153.073841] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  154.031008] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  154.031113] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  154.031116] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  154.084458] % rmmod test_klp_callbacks_demo2
[  154.161744] % rmmod test_klp_callbacks_demo
[  154.245192] livepatch: kernel.ftrace_enabled = 1
[  154.253557] ===== TEST: basic shadow variable API =====
[  154.256693] % modprobe test_klp_shadow_vars
[  154.258215] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  154.258218] test_klp_shadow_vars:   got expected NULL result
[  154.258220] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  154.258221] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  154.258224] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  154.258226] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  154.258228] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  154.258229] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  154.258232] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  154.258233] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  154.258235] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  154.258236] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  154.258239] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  154.258240] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  154.258242] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  154.258243] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  154.258244] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  154.258246] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  154.258268] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  154.258269] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  154.258270] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  154.258271] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  154.258273] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  154.258274] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  154.258275] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  154.258276] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  154.258278] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  154.258280] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  154.258281] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  154.258283] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  154.258284] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  154.258286] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  154.258287] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  154.258289] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  154.258290] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  154.258292] test_klp_shadow_vars:   got expected NULL result
[  154.258292] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  154.258294] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  154.258295] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  154.258297] test_klp_shadow_vars:   got expected NULL result
[  154.258297] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  154.258299] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  154.258300] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  154.258301] test_klp_shadow_vars:   got expected NULL result
[  154.258302] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  154.258303] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  154.258304] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  154.258306] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  154.258307] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  154.258308] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  154.258317] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  154.258318] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  154.258319] test_klp_shadow_vars:   got expected NULL result
[  154.258320] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  154.258321] test_klp_shadow_vars:   got expected NULL result
[  154.258322] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  154.258323] test_klp_shadow_vars:   got expected NULL result
[  154.259549] % rmmod test_klp_shadow_vars
[  154.364539] livepatch: kernel.ftrace_enabled = 1
[  154.373051] ===== TEST: system state modification =====
[  154.376288] % modprobe test_klp_state
[  154.377808] livepatch: enabling patch 'test_klp_state'
[  154.377810] livepatch: 'test_klp_state': initializing patching transition
[  154.377832] test_klp_state: pre_patch_callback: vmlinux
[  154.377833] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  154.377834] livepatch: 'test_klp_state': starting patching transition
[  155.951098] livepatch: 'test_klp_state': completing patching transition
[  155.951196] test_klp_state: post_patch_callback: vmlinux
[  155.951198] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  155.951199] livepatch: 'test_klp_state': patching complete
[  156.005967] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  156.005986] livepatch: 'test_klp_state': initializing unpatching transition
[  156.006003] test_klp_state: pre_unpatch_callback: vmlinux
[  156.006004] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  156.006005] livepatch: 'test_klp_state': starting unpatching transition
[  156.991099] livepatch: 'test_klp_state': completing unpatching transition
[  156.991197] test_klp_state: post_unpatch_callback: vmlinux
[  156.991199] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  156.991201] livepatch: 'test_klp_state': unpatching complete
[  157.016096] % rmmod test_klp_state
[  157.119439] ===== TEST: taking over system state modification =====
[  157.122658] % modprobe test_klp_state
[  157.124299] livepatch: enabling patch 'test_klp_state'
[  157.124302] livepatch: 'test_klp_state': initializing patching transition
[  157.124324] test_klp_state: pre_patch_callback: vmlinux
[  157.124325] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  157.124326] livepatch: 'test_klp_state': starting patching transition
[  158.031004] livepatch: 'test_klp_state': completing patching transition
[  158.031105] test_klp_state: post_patch_callback: vmlinux
[  158.031107] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  158.031109] livepatch: 'test_klp_state': patching complete
[  158.044647] % modprobe test_klp_state2
[  158.046174] livepatch: enabling patch 'test_klp_state2'
[  158.046176] livepatch: 'test_klp_state2': initializing patching transition
[  158.046194] test_klp_state2: pre_patch_callback: vmlinux
[  158.046195] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  158.046197] livepatch: 'test_klp_state2': starting patching transition
[  158.991060] livepatch: 'test_klp_state2': completing patching transition
[  158.991184] test_klp_state2: post_patch_callback: vmlinux
[  158.991185] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  158.991186] livepatch: 'test_klp_state2': patching complete
[  159.065518] % rmmod test_klp_state
[  159.130779] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  159.130797] livepatch: 'test_klp_state2': initializing unpatching transition
[  159.130818] test_klp_state2: pre_unpatch_callback: vmlinux
[  159.130819] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  159.130820] livepatch: 'test_klp_state2': starting unpatching transition
[  160.911085] livepatch: 'test_klp_state2': completing unpatching transition
[  160.911224] test_klp_state2: post_unpatch_callback: vmlinux
[  160.911226] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  160.911227] livepatch: 'test_klp_state2': unpatching complete
[  160.948036] % rmmod test_klp_state2
[  161.059424] ===== TEST: compatible cumulative livepatches =====
[  161.062474] % modprobe test_klp_state2
[  161.063931] livepatch: enabling patch 'test_klp_state2'
[  161.063934] livepatch: 'test_klp_state2': initializing patching transition
[  161.063957] test_klp_state2: pre_patch_callback: vmlinux
[  161.063958] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  161.063959] livepatch: 'test_klp_state2': starting patching transition
[  162.671079] livepatch: 'test_klp_state2': completing patching transition
[  162.671184] test_klp_state2: post_patch_callback: vmlinux
[  162.671186] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  162.671188] livepatch: 'test_klp_state2': patching complete
[  162.694355] % modprobe test_klp_state3
[  162.695852] livepatch: enabling patch 'test_klp_state3'
[  162.695855] livepatch: 'test_klp_state3': initializing patching transition
[  162.695877] test_klp_state3: pre_patch_callback: vmlinux
[  162.695878] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  162.695879] livepatch: 'test_klp_state3': starting patching transition
[  163.951036] livepatch: 'test_klp_state3': completing patching transition
[  163.951139] test_klp_state3: post_patch_callback: vmlinux
[  163.951141] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  163.951142] livepatch: 'test_klp_state3': patching complete
[  164.019372] % rmmod test_klp_state2
[  164.093821] % modprobe test_klp_state2
[  164.095460] livepatch: enabling patch 'test_klp_state2'
[  164.095463] livepatch: 'test_klp_state2': initializing patching transition
[  164.095484] test_klp_state2: pre_patch_callback: vmlinux
[  164.095485] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  164.095487] livepatch: 'test_klp_state2': starting patching transition
[  165.871122] livepatch: 'test_klp_state2': completing patching transition
[  165.871280] test_klp_state2: post_patch_callback: vmlinux
[  165.871281] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  165.871283] livepatch: 'test_klp_state2': patching complete
[  165.926447] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  165.926486] livepatch: 'test_klp_state2': initializing unpatching transition
[  165.926507] test_klp_state2: pre_unpatch_callback: vmlinux
[  165.926508] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  165.926509] livepatch: 'test_klp_state2': starting unpatching transition
[  166.831076] livepatch: 'test_klp_state2': completing unpatching transition
[  166.831199] test_klp_state2: post_unpatch_callback: vmlinux
[  166.831201] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  166.831203] livepatch: 'test_klp_state2': unpatching complete
[  166.835243] % rmmod test_klp_state2
[  166.901777] % rmmod test_klp_state3
[  166.969742] ===== TEST: incompatible cumulative livepatches =====
[  166.972899] % modprobe test_klp_state2
[  166.974399] livepatch: enabling patch 'test_klp_state2'
[  166.974401] livepatch: 'test_klp_state2': initializing patching transition
[  166.974420] test_klp_state2: pre_patch_callback: vmlinux
[  166.974422] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  166.974423] livepatch: 'test_klp_state2': starting patching transition
[  168.681063] livepatch: 'test_klp_state2': completing patching transition
[  168.681165] test_klp_state2: post_patch_callback: vmlinux
[  168.681167] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  168.681169] livepatch: 'test_klp_state2': patching complete
[  168.703685] % modprobe test_klp_state
[  168.705124] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  168.860784] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  168.860833] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  168.860851] livepatch: 'test_klp_state2': initializing unpatching transition
[  168.860909] test_klp_state2: pre_unpatch_callback: vmlinux
[  168.860910] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  168.860911] livepatch: 'test_klp_state2': starting unpatching transition
[  169.871047] livepatch: 'test_klp_state2': completing unpatching transition
[  169.871186] test_klp_state2: post_unpatch_callback: vmlinux
[  169.871188] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  169.871189] livepatch: 'test_klp_state2': unpatching complete
[  169.971989] % rmmod test_klp_state2
[  170.114423] livepatch: kernel.ftrace_enabled = 1
[  170.122713] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  170.124491] livepatch: kernel.ftrace_enabled = 0
[  170.124552] % modprobe test_klp_livepatch
[  170.125916] livepatch: enabling patch 'test_klp_livepatch'
[  170.125918] livepatch: 'test_klp_livepatch': initializing patching transition
[  170.125942] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  170.125945] livepatch: failed to patch object 'vmlinux'
[  170.125946] livepatch: failed to enable patch 'test_klp_livepatch'
[  170.125947] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  170.125948] livepatch: 'test_klp_livepatch': completing unpatching transition
[  170.126056] livepatch: 'test_klp_livepatch': unpatching complete
[  170.260823] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  170.262584] livepatch: kernel.ftrace_enabled = 1
[  170.265470] % modprobe test_klp_livepatch
[  170.266711] livepatch: enabling patch 'test_klp_livepatch'
[  170.266712] livepatch: 'test_klp_livepatch': initializing patching transition
[  170.267782] livepatch: 'test_klp_livepatch': starting patching transition
[  171.791076] livepatch: 'test_klp_livepatch': completing patching transition
[  171.791226] livepatch: 'test_klp_livepatch': patching complete
[  171.797053] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  171.798001] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  171.798020] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  171.798035] livepatch: 'test_klp_livepatch': starting unpatching transition
[  172.831042] livepatch: 'test_klp_livepatch': completing unpatching transition
[  172.832563] livepatch: 'test_klp_livepatch': unpatching complete
[  172.908336] % rmmod test_klp_livepatch
[  172.983414] livepatch: kernel.ftrace_enabled = 1
[  172.991780] ===== TEST: sysfs test =====
[  172.994796] % modprobe test_klp_livepatch
[  172.996248] livepatch: enabling patch 'test_klp_livepatch'
[  172.996250] livepatch: 'test_klp_livepatch': initializing patching transition
[  172.997482] livepatch: 'test_klp_livepatch': starting patching transition
[  174.671056] livepatch: 'test_klp_livepatch': completing patching transition
[  174.671194] livepatch: 'test_klp_livepatch': patching complete
[  174.734417] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  174.734432] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  174.734466] livepatch: 'test_klp_livepatch': starting unpatching transition
[  175.711081] livepatch: 'test_klp_livepatch': completing unpatching transition
[  175.712575] livepatch: 'test_klp_livepatch': unpatching complete
[  175.744085] % rmmod test_klp_livepatch
[  175.808160] ===== TEST: sysfs test object/patched =====
[  175.810980] % modprobe test_klp_callbacks_demo
[  175.812208] livepatch: enabling patch 'test_klp_callbacks_demo'
[  175.812210] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  175.812230] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  175.812231] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  176.911051] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  176.911161] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  176.911163] livepatch: 'test_klp_callbacks_demo': patching complete
[  176.934731] % modprobe test_klp_callbacks_mod
[  176.935992] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  176.935994] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  176.935996] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  176.936013] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  176.937945] % rmmod test_klp_callbacks_mod
[  176.938946] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  176.938961] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  176.938963] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  176.938964] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  176.991789] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  176.991808] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  176.991828] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  176.991830] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  178.191025] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  178.191124] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  178.191126] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  178.202777] % rmmod test_klp_callbacks_demo
[  178.318263] livepatch: kernel.ftrace_enabled = 1
[  178.326039] ===== TEST: basic function patching =====
[  178.328835] % modprobe test_klp_livepatch
[  178.330156] livepatch: enabling patch 'test_klp_livepatch'
[  178.330158] livepatch: 'test_klp_livepatch': initializing patching transition
[  178.331256] livepatch: 'test_klp_livepatch': starting patching transition
[  179.711061] livepatch: 'test_klp_livepatch': completing patching transition
[  179.711168] livepatch: 'test_klp_livepatch': patching complete
[  179.757176] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  179.757196] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  179.757219] livepatch: 'test_klp_livepatch': starting unpatching transition
[  180.751089] livepatch: 'test_klp_livepatch': completing unpatching transition
[  180.752537] livepatch: 'test_klp_livepatch': unpatching complete
[  180.767212] % rmmod test_klp_livepatch
[  180.830459] ===== TEST: multiple livepatches =====
[  180.833537] % modprobe test_klp_livepatch
[  180.834932] livepatch: enabling patch 'test_klp_livepatch'
[  180.834933] livepatch: 'test_klp_livepatch': initializing patching transition
[  180.836072] livepatch: 'test_klp_livepatch': starting patching transition
[  181.711030] livepatch: 'test_klp_livepatch': completing patching transition
[  181.711129] livepatch: 'test_klp_livepatch': patching complete
[  181.753931] test_klp_livepatch: this has been live patched
[  181.758075] % modprobe test_klp_atomic_replace replace=0
[  181.759630] livepatch: enabling patch 'test_klp_atomic_replace'
[  181.759632] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  181.760761] livepatch: 'test_klp_atomic_replace': starting patching transition
[  182.751097] livepatch: 'test_klp_atomic_replace': completing patching transition
[  182.751210] livepatch: 'test_klp_atomic_replace': patching complete
[  182.779987] test_klp_livepatch: this has been live patched
[  182.780949] test_klp_atomic_replace: this has been live patched
[  182.781132] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  182.781152] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  182.781172] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  183.711178] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  183.712627] livepatch: 'test_klp_atomic_replace': unpatching complete
[  183.791173] % rmmod test_klp_atomic_replace
[  183.881579] test_klp_livepatch: this has been live patched
[  183.882598] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  183.882616] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  183.882634] livepatch: 'test_klp_livepatch': starting unpatching transition
[  184.751183] livepatch: 'test_klp_livepatch': completing unpatching transition
[  184.752715] livepatch: 'test_klp_livepatch': unpatching complete
[  184.791884] % rmmod test_klp_livepatch
[  184.921013] ===== TEST: atomic replace livepatch =====
[  184.924117] % modprobe test_klp_livepatch
[  184.925507] livepatch: enabling patch 'test_klp_livepatch'
[  184.925509] livepatch: 'test_klp_livepatch': initializing patching transition
[  184.926666] livepatch: 'test_klp_livepatch': starting patching transition
[  185.791155] livepatch: 'test_klp_livepatch': completing patching transition
[  185.791263] livepatch: 'test_klp_livepatch': patching complete
[  185.844460] test_klp_livepatch: this has been live patched
[  185.848202] % modprobe test_klp_atomic_replace replace=1
[  185.849784] livepatch: enabling patch 'test_klp_atomic_replace'
[  185.849786] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  185.850899] livepatch: 'test_klp_atomic_replace': starting patching transition
[  186.751268] livepatch: 'test_klp_atomic_replace': completing patching transition
[  186.752724] livepatch: 'test_klp_atomic_replace': patching complete
[  186.769820] test_klp_atomic_replace: this has been live patched
[  186.771001] % rmmod test_klp_livepatch
[  186.842577] test_klp_atomic_replace: this has been live patched
[  186.842713] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  186.842732] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  186.842752] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  187.711155] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  187.712686] livepatch: 'test_klp_atomic_replace': unpatching complete
[  187.751949] % rmmod test_klp_atomic_replace
[  187.875356] livepatch: kernel.ftrace_enabled = 1
[  187.883440] ===== TEST: target module before livepatch =====
[  187.886603] % modprobe test_klp_callbacks_mod
[  187.887986] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  187.891200] % modprobe test_klp_callbacks_demo
[  187.892630] livepatch: enabling patch 'test_klp_callbacks_demo'
[  187.892632] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  187.892658] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  187.892659] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  187.892660] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  189.071175] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  189.071347] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  189.071350] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  189.071351] livepatch: 'test_klp_callbacks_demo': patching complete
[  189.113416] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  189.113437] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  189.113459] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  189.113460] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  189.113461] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  190.831161] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  190.831300] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  190.831303] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  190.831304] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  190.928590] % rmmod test_klp_callbacks_demo
[  190.981743] % rmmod test_klp_callbacks_mod
[  190.982844] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  191.068717] ===== TEST: module_coming notifier =====
[  191.071881] % modprobe test_klp_callbacks_demo
[  191.073324] livepatch: enabling patch 'test_klp_callbacks_demo'
[  191.073326] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  191.073345] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  191.073347] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  192.761063] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  192.761166] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  192.761168] livepatch: 'test_klp_callbacks_demo': patching complete
[  192.804600] % modprobe test_klp_callbacks_mod
[  192.806035] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  192.806038] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  192.806040] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  192.806058] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  192.806411] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  192.806429] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  192.806450] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  192.806452] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  192.806453] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  193.951153] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  193.951254] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  193.951256] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  193.951257] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  194.016717] % rmmod test_klp_callbacks_demo
[  194.111640] % rmmod test_klp_callbacks_mod
[  194.112834] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  194.179536] ===== TEST: module_going notifier =====
[  194.182529] % modprobe test_klp_callbacks_mod
[  194.183902] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  194.186979] % modprobe test_klp_callbacks_demo
[  194.188306] livepatch: enabling patch 'test_klp_callbacks_demo'
[  194.188308] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  194.188334] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  194.188336] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  194.188337] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  195.871146] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  195.871247] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  195.871248] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  195.871250] livepatch: 'test_klp_callbacks_demo': patching complete
[  195.917690] % rmmod test_klp_callbacks_mod
[  195.918839] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  195.918874] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  195.918876] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  195.918877] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  196.000811] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  196.000829] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  196.000847] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  196.000848] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  196.831134] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  196.831258] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  196.831276] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  196.909237] % rmmod test_klp_callbacks_demo
[  196.999252] ===== TEST: module_coming and module_going notifiers =====
[  197.002219] % modprobe test_klp_callbacks_demo
[  197.003720] livepatch: enabling patch 'test_klp_callbacks_demo'
[  197.003722] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  197.003761] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  197.003762] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  197.951097] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  197.951197] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  197.951199] livepatch: 'test_klp_callbacks_demo': patching complete
[  198.023498] % modprobe test_klp_callbacks_mod
[  198.024865] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  198.024868] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  198.024870] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  198.024887] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  198.026043] % rmmod test_klp_callbacks_mod
[  198.027153] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  198.027169] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  198.027171] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  198.027172] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  198.110789] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  198.110807] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  198.110828] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  198.110830] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  199.881138] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  199.881237] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  199.881239] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  199.925505] % rmmod test_klp_callbacks_demo
[  199.999151] ===== TEST: target module not present =====
[  200.002145] % modprobe test_klp_callbacks_demo
[  200.003699] livepatch: enabling patch 'test_klp_callbacks_demo'
[  200.003701] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  200.003721] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  200.003723] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  200.911124] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  200.911242] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  200.911244] livepatch: 'test_klp_callbacks_demo': patching complete
[  200.919249] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  200.919267] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  200.919288] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  200.919289] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  201.951160] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  201.951277] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  201.951279] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  202.028867] % rmmod test_klp_callbacks_demo
[  202.119054] ===== TEST: pre-patch callback -ENODEV =====
[  202.122040] % modprobe test_klp_callbacks_mod
[  202.123508] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  202.123862] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  202.125317] livepatch: enabling patch 'test_klp_callbacks_demo'
[  202.125319] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  202.125341] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  202.125342] livepatch: pre-patch callback failed for object 'vmlinux'
[  202.125343] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  202.125344] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  202.125345] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  202.125496] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  202.250789] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  202.251582] % rmmod test_klp_callbacks_mod
[  202.252724] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  202.348771] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  202.351804] % modprobe test_klp_callbacks_demo
[  202.353355] livepatch: enabling patch 'test_klp_callbacks_demo'
[  202.353357] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  202.353392] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  202.353393] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  203.951197] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  203.951351] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  203.951353] livepatch: 'test_klp_callbacks_demo': patching complete
[  203.979670] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  203.980548] % modprobe test_klp_callbacks_mod
[  203.981920] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  203.981922] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  203.981924] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  203.981925] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  204.130800] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  204.130845] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  204.130862] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  204.130882] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  204.130884] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  205.951235] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  205.951341] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  205.951343] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  206.046975] % rmmod test_klp_callbacks_demo
[  206.128457] ===== TEST: multiple target modules =====
[  206.131336] % modprobe test_klp_callbacks_busy block_transition=N
[  206.132672] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  206.132677] test_klp_callbacks_busy: busymod_work_func enter
[  206.132679] test_klp_callbacks_busy: busymod_work_func exit
[  206.135860] % modprobe test_klp_callbacks_demo
[  206.137206] livepatch: enabling patch 'test_klp_callbacks_demo'
[  206.137207] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  206.137228] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  206.137229] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  206.138577] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  207.871214] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  207.871314] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  207.871316] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  207.871318] livepatch: 'test_klp_callbacks_demo': patching complete
[  207.969934] % modprobe test_klp_callbacks_mod
[  207.971401] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  207.971404] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  207.971406] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  207.971423] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  207.972674] % rmmod test_klp_callbacks_mod
[  207.973849] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  207.973866] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  207.973868] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  207.973870] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  208.050976] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  208.050996] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  208.051017] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  208.051018] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  208.051020] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  208.911216] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  208.912965] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  208.912967] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  208.912969] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  208.959486] % rmmod test_klp_callbacks_demo
[  209.071781] % rmmod test_klp_callbacks_busy
[  209.072943] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  209.149873] ===== TEST: busy target module =====
[  209.152833] % modprobe test_klp_callbacks_busy block_transition=Y
[  209.154258] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  209.154262] test_klp_callbacks_busy: busymod_work_func enter
[  209.157628] % modprobe test_klp_callbacks_demo
[  209.159018] livepatch: enabling patch 'test_klp_callbacks_demo'
[  209.159020] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  209.159040] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  209.159041] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  209.160430] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  209.165518] % modprobe test_klp_callbacks_mod
[  209.166893] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  209.166896] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  209.166914] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  209.168092] % rmmod test_klp_callbacks_mod
[  209.169182] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  209.169198] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  209.169200] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  209.250960] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  209.250978] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  209.251083] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  211.871203] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  211.872965] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  211.872967] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  211.872969] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  211.971835] % rmmod test_klp_callbacks_demo
[  212.051698] % rmmod test_klp_callbacks_busy
[  212.090506] test_klp_callbacks_busy: busymod_work_func exit
[  212.090513] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  212.169096] ===== TEST: multiple livepatches =====
[  212.172221] % modprobe test_klp_callbacks_demo
[  212.173625] livepatch: enabling patch 'test_klp_callbacks_demo'
[  212.173627] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  212.173645] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  212.173646] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  213.881119] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  213.881238] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  213.881240] livepatch: 'test_klp_callbacks_demo': patching complete
[  213.904735] % modprobe test_klp_callbacks_demo2
[  213.906252] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  213.906254] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  213.906291] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  213.906292] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  214.911228] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  214.911330] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  214.911332] livepatch: 'test_klp_callbacks_demo2': patching complete
[  214.923290] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  214.923309] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  214.923323] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  214.923324] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  215.951189] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  215.951289] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  215.951291] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  216.032305] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  216.032322] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  216.032338] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  216.032339] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  216.911208] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  216.911327] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  216.911329] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  216.941200] % rmmod test_klp_callbacks_demo2
[  217.011815] % rmmod test_klp_callbacks_demo
[  217.089875] ===== TEST: atomic replace =====
[  217.092945] % modprobe test_klp_callbacks_demo
[  217.094433] livepatch: enabling patch 'test_klp_callbacks_demo'
[  217.094436] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  217.094455] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  217.094457] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  217.951266] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  217.951371] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  217.951372] livepatch: 'test_klp_callbacks_demo': patching complete
[  218.014048] % modprobe test_klp_callbacks_demo2 replace=1
[  218.015488] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  218.015491] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  218.015512] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  218.015514] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  219.631259] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  219.631381] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  219.631383] livepatch: 'test_klp_callbacks_demo2': patching complete
[  219.643212] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  219.643241] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  219.643273] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  219.643274] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  220.831217] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  220.831316] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  220.831318] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  220.853623] % rmmod test_klp_callbacks_demo2
[  220.931690] % rmmod test_klp_callbacks_demo
[  221.032866] livepatch: kernel.ftrace_enabled = 1
[  221.041249] ===== TEST: basic shadow variable API =====
[  221.044342] % modprobe test_klp_shadow_vars
[  221.046005] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  221.046008] test_klp_shadow_vars:   got expected NULL result
[  221.046010] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  221.046011] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  221.046015] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  221.046016] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  221.046019] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  221.046020] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  221.046022] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  221.046024] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  221.046026] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  221.046028] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  221.046030] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  221.046031] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  221.046034] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  221.046035] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  221.046036] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  221.046038] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  221.046039] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  221.046041] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  221.046042] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  221.046043] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  221.046045] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  221.046046] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  221.046047] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  221.046049] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  221.046050] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  221.046052] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  221.046054] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  221.046056] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  221.046057] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  221.046059] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  221.046061] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  221.046063] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  221.046064] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  221.046066] test_klp_shadow_vars:   got expected NULL result
[  221.046067] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  221.046068] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  221.046070] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  221.046071] test_klp_shadow_vars:   got expected NULL result
[  221.046072] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  221.046073] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  221.046075] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  221.046076] test_klp_shadow_vars:   got expected NULL result
[  221.046077] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  221.046079] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  221.046080] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  221.046081] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  221.046083] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  221.046084] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  221.046092] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  221.046093] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  221.046094] test_klp_shadow_vars:   got expected NULL result
[  221.046095] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  221.046097] test_klp_shadow_vars:   got expected NULL result
[  221.046098] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  221.046099] test_klp_shadow_vars:   got expected NULL result
[  221.047460] % rmmod test_klp_shadow_vars
[  221.132199] livepatch: kernel.ftrace_enabled = 1
[  221.140198] ===== TEST: system state modification =====
[  221.143166] % modprobe test_klp_state
[  221.144614] livepatch: enabling patch 'test_klp_state'
[  221.144616] livepatch: 'test_klp_state': initializing patching transition
[  221.144637] test_klp_state: pre_patch_callback: vmlinux
[  221.144638] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  221.144639] livepatch: 'test_klp_state': starting patching transition
[  222.111272] livepatch: 'test_klp_state': completing patching transition
[  222.111377] test_klp_state: post_patch_callback: vmlinux
[  222.111379] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  222.111381] livepatch: 'test_klp_state': patching complete
[  222.162434] % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
[  222.162453] livepatch: 'test_klp_state': initializing unpatching transition
[  222.162474] test_klp_state: pre_unpatch_callback: vmlinux
[  222.162476] test_klp_state: restore_console_loglevel: restoring console_loglevel
[  222.162477] livepatch: 'test_klp_state': starting unpatching transition
[  223.951243] livepatch: 'test_klp_state': completing unpatching transition
[  223.951343] test_klp_state: post_unpatch_callback: vmlinux
[  223.951345] test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
[  223.951346] livepatch: 'test_klp_state': unpatching complete
[  223.978524] % rmmod test_klp_state
[  224.049861] ===== TEST: taking over system state modification =====
[  224.052982] % modprobe test_klp_state
[  224.054535] livepatch: enabling patch 'test_klp_state'
[  224.054537] livepatch: 'test_klp_state': initializing patching transition
[  224.054558] test_klp_state: pre_patch_callback: vmlinux
[  224.054559] test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
[  224.054561] livepatch: 'test_klp_state': starting patching transition
[  224.921252] livepatch: 'test_klp_state': completing patching transition
[  224.921353] test_klp_state: post_patch_callback: vmlinux
[  224.921355] test_klp_state: fix_console_loglevel: fixing console_loglevel
[  224.921357] livepatch: 'test_klp_state': patching complete
[  224.974637] % modprobe test_klp_state2
[  224.976246] livepatch: enabling patch 'test_klp_state2'
[  224.976248] livepatch: 'test_klp_state2': initializing patching transition
[  224.976275] test_klp_state2: pre_patch_callback: vmlinux
[  224.976276] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  224.976278] livepatch: 'test_klp_state2': starting patching transition
[  226.031256] livepatch: 'test_klp_state2': completing patching transition
[  226.031388] test_klp_state2: post_patch_callback: vmlinux
[  226.031389] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  226.031390] livepatch: 'test_klp_state2': patching complete
[  226.097150] % rmmod test_klp_state
[  226.170953] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  226.170972] livepatch: 'test_klp_state2': initializing unpatching transition
[  226.170994] test_klp_state2: pre_unpatch_callback: vmlinux
[  226.170995] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  226.170996] livepatch: 'test_klp_state2': starting unpatching transition
[  227.951209] livepatch: 'test_klp_state2': completing unpatching transition
[  227.951314] test_klp_state2: post_unpatch_callback: vmlinux
[  227.951317] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  227.951318] livepatch: 'test_klp_state2': unpatching complete
[  227.987229] % rmmod test_klp_state2
[  228.048401] ===== TEST: compatible cumulative livepatches =====
[  228.051472] % modprobe test_klp_state2
[  228.052836] livepatch: enabling patch 'test_klp_state2'
[  228.052839] livepatch: 'test_klp_state2': initializing patching transition
[  228.052858] test_klp_state2: pre_patch_callback: vmlinux
[  228.052860] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  228.052861] livepatch: 'test_klp_state2': starting patching transition
[  229.071292] livepatch: 'test_klp_state2': completing patching transition
[  229.071407] test_klp_state2: post_patch_callback: vmlinux
[  229.071409] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  229.071410] livepatch: 'test_klp_state2': patching complete
[  229.174501] % modprobe test_klp_state3
[  229.175964] livepatch: enabling patch 'test_klp_state3'
[  229.175966] livepatch: 'test_klp_state3': initializing patching transition
[  229.175984] test_klp_state3: pre_patch_callback: vmlinux
[  229.175985] test_klp_state3: allocate_loglevel_state: space to store console_loglevel already allocated
[  229.175986] livepatch: 'test_klp_state3': starting patching transition
[  230.031287] livepatch: 'test_klp_state3': completing patching transition
[  230.031407] test_klp_state3: post_patch_callback: vmlinux
[  230.031409] test_klp_state3: fix_console_loglevel: taking over the console_loglevel change
[  230.031410] livepatch: 'test_klp_state3': patching complete
[  230.092633] % rmmod test_klp_state2
[  230.174017] % modprobe test_klp_state2
[  230.175415] livepatch: enabling patch 'test_klp_state2'
[  230.175416] livepatch: 'test_klp_state2': initializing patching transition
[  230.175437] test_klp_state2: pre_patch_callback: vmlinux
[  230.175438] test_klp_state2: allocate_loglevel_state: space to store console_loglevel already allocated
[  230.175453] livepatch: 'test_klp_state2': starting patching transition
[  231.871289] livepatch: 'test_klp_state2': completing patching transition
[  231.871392] test_klp_state2: post_patch_callback: vmlinux
[  231.871393] test_klp_state2: fix_console_loglevel: taking over the console_loglevel change
[  231.871394] livepatch: 'test_klp_state2': patching complete
[  231.902873] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  231.902893] livepatch: 'test_klp_state2': initializing unpatching transition
[  231.902909] test_klp_state2: pre_unpatch_callback: vmlinux
[  231.902910] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  231.902911] livepatch: 'test_klp_state2': starting unpatching transition
[  232.831270] livepatch: 'test_klp_state2': completing unpatching transition
[  232.831371] test_klp_state2: post_unpatch_callback: vmlinux
[  232.831373] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  232.831374] livepatch: 'test_klp_state2': unpatching complete
[  232.912312] % rmmod test_klp_state2
[  232.961704] % rmmod test_klp_state3
[  233.039460] ===== TEST: incompatible cumulative livepatches =====
[  233.042189] % modprobe test_klp_state2
[  233.043520] livepatch: enabling patch 'test_klp_state2'
[  233.043522] livepatch: 'test_klp_state2': initializing patching transition
[  233.043542] test_klp_state2: pre_patch_callback: vmlinux
[  233.043543] test_klp_state2: allocate_loglevel_state: allocating space to store console_loglevel
[  233.043545] livepatch: 'test_klp_state2': starting patching transition
[  234.191241] livepatch: 'test_klp_state2': completing patching transition
[  234.191348] test_klp_state2: post_patch_callback: vmlinux
[  234.191365] test_klp_state2: fix_console_loglevel: fixing console_loglevel
[  234.191368] livepatch: 'test_klp_state2': patching complete
[  234.263631] % modprobe test_klp_state
[  234.265068] livepatch: Livepatch patch (test_klp_state) is not compatible with the already installed livepatches.
[  234.380932] modprobe: ERROR: could not insert 'test_klp_state': Invalid argument
[  234.380979] % echo 0 > /sys/kernel/livepatch/test_klp_state2/enabled
[  234.380997] livepatch: 'test_klp_state2': initializing unpatching transition
[  234.381018] test_klp_state2: pre_unpatch_callback: vmlinux
[  234.381019] test_klp_state2: restore_console_loglevel: restoring console_loglevel
[  234.381020] livepatch: 'test_klp_state2': starting unpatching transition
[  235.951273] livepatch: 'test_klp_state2': completing unpatching transition
[  235.951373] test_klp_state2: post_unpatch_callback: vmlinux
[  235.951375] test_klp_state2: free_loglevel_state: freeing space for the stored console_loglevel
[  235.951376] livepatch: 'test_klp_state2': unpatching complete
[  235.994953] % rmmod test_klp_state2
[  236.093180] livepatch: kernel.ftrace_enabled = 1
[  236.101310] ===== TEST: livepatch interaction with ftrace_enabled sysctl =====
[  236.102950] livepatch: kernel.ftrace_enabled = 0
[  236.103030] % modprobe test_klp_livepatch
[  236.104411] livepatch: enabling patch 'test_klp_livepatch'
[  236.104414] livepatch: 'test_klp_livepatch': initializing patching transition
[  236.104437] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
[  236.104439] livepatch: failed to patch object 'vmlinux'
[  236.104440] livepatch: failed to enable patch 'test_klp_livepatch'
[  236.104441] livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
[  236.104442] livepatch: 'test_klp_livepatch': completing unpatching transition
[  236.104560] livepatch: 'test_klp_livepatch': unpatching complete
[  236.260929] modprobe: ERROR: could not insert 'test_klp_livepatch': Device or resource busy
[  236.262507] livepatch: kernel.ftrace_enabled = 1
[  236.265215] % modprobe test_klp_livepatch
[  236.266486] livepatch: enabling patch 'test_klp_livepatch'
[  236.266488] livepatch: 'test_klp_livepatch': initializing patching transition
[  236.267596] livepatch: 'test_klp_livepatch': starting patching transition
[  237.791212] livepatch: 'test_klp_livepatch': completing patching transition
[  237.791310] livepatch: 'test_klp_livepatch': patching complete
[  237.797154] livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
[  237.798043] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  237.798095] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  237.798109] livepatch: 'test_klp_livepatch': starting unpatching transition
[  238.831322] livepatch: 'test_klp_livepatch': completing unpatching transition
[  238.832826] livepatch: 'test_klp_livepatch': unpatching complete
[  238.908640] % rmmod test_klp_livepatch
[  238.992263] livepatch: kernel.ftrace_enabled = 1
[  238.999933] ===== TEST: sysfs test =====
[  239.002807] % modprobe test_klp_livepatch
[  239.004110] livepatch: enabling patch 'test_klp_livepatch'
[  239.004111] livepatch: 'test_klp_livepatch': initializing patching transition
[  239.005181] livepatch: 'test_klp_livepatch': starting patching transition
[  240.111262] livepatch: 'test_klp_livepatch': completing patching transition
[  240.111381] livepatch: 'test_klp_livepatch': patching complete
[  240.132783] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  240.132799] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  240.132815] livepatch: 'test_klp_livepatch': starting unpatching transition
[  241.081328] livepatch: 'test_klp_livepatch': completing unpatching transition
[  241.082831] livepatch: 'test_klp_livepatch': unpatching complete
[  241.142598] % rmmod test_klp_livepatch
[  241.210158] ===== TEST: sysfs test object/patched =====
[  241.213283] % modprobe test_klp_callbacks_demo
[  241.214762] livepatch: enabling patch 'test_klp_callbacks_demo'
[  241.214764] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  241.214784] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  241.214785] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  242.031320] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  242.031449] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  242.031451] livepatch: 'test_klp_callbacks_demo': patching complete
[  242.136182] % modprobe test_klp_callbacks_mod
[  242.137515] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  242.137517] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  242.137519] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  242.137535] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  242.139783] % rmmod test_klp_callbacks_mod
[  242.140942] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  242.140957] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  242.140959] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  242.140960] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  242.231991] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  242.232011] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  242.232030] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  242.232032] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  243.071322] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  243.071422] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  243.071424] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  243.141124] % rmmod test_klp_callbacks_demo
[  243.282256] livepatch: kernel.ftrace_enabled = 1
[  243.290569] ===== TEST: basic function patching =====
[  243.293596] % modprobe test_klp_livepatch
[  243.295013] livepatch: enabling patch 'test_klp_livepatch'
[  243.295016] livepatch: 'test_klp_livepatch': initializing patching transition
[  243.296162] livepatch: 'test_klp_livepatch': starting patching transition
[  244.911383] livepatch: 'test_klp_livepatch': completing patching transition
[  244.911489] livepatch: 'test_klp_livepatch': patching complete
[  244.924091] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  244.924112] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  244.924134] livepatch: 'test_klp_livepatch': starting unpatching transition
[  245.871319] livepatch: 'test_klp_livepatch': completing unpatching transition
[  245.872799] livepatch: 'test_klp_livepatch': unpatching complete
[  245.934000] % rmmod test_klp_livepatch
[  246.029530] ===== TEST: multiple livepatches =====
[  246.032436] % modprobe test_klp_livepatch
[  246.033861] livepatch: enabling patch 'test_klp_livepatch'
[  246.033863] livepatch: 'test_klp_livepatch': initializing patching transition
[  246.034968] livepatch: 'test_klp_livepatch': starting patching transition
[  247.711339] livepatch: 'test_klp_livepatch': completing patching transition
[  247.711489] livepatch: 'test_klp_livepatch': patching complete
[  247.763427] test_klp_livepatch: this has been live patched
[  247.767396] % modprobe test_klp_atomic_replace replace=0
[  247.768853] livepatch: enabling patch 'test_klp_atomic_replace'
[  247.768854] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  247.769960] livepatch: 'test_klp_atomic_replace': starting patching transition
[  248.751335] livepatch: 'test_klp_atomic_replace': completing patching transition
[  248.751471] livepatch: 'test_klp_atomic_replace': patching complete
[  248.788134] test_klp_livepatch: this has been live patched
[  248.789014] test_klp_atomic_replace: this has been live patched
[  248.789161] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  248.789181] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  248.789197] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  249.711272] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  249.712588] livepatch: 'test_klp_atomic_replace': unpatching complete
[  249.798070] % rmmod test_klp_atomic_replace
[  249.851728] test_klp_livepatch: this has been live patched
[  249.852707] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  249.852727] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  249.852745] livepatch: 'test_klp_livepatch': starting unpatching transition
[  250.751345] livepatch: 'test_klp_livepatch': completing unpatching transition
[  250.752836] livepatch: 'test_klp_livepatch': unpatching complete
[  250.761513] % rmmod test_klp_livepatch
[  250.851360] ===== TEST: atomic replace livepatch =====
[  250.854431] % modprobe test_klp_livepatch
[  250.855791] livepatch: enabling patch 'test_klp_livepatch'
[  250.855793] livepatch: 'test_klp_livepatch': initializing patching transition
[  250.856996] livepatch: 'test_klp_livepatch': starting patching transition
[  251.711343] livepatch: 'test_klp_livepatch': completing patching transition
[  251.711461] livepatch: 'test_klp_livepatch': patching complete
[  251.773219] test_klp_livepatch: this has been live patched
[  251.777357] % modprobe test_klp_atomic_replace replace=1
[  251.778873] livepatch: enabling patch 'test_klp_atomic_replace'
[  251.778875] livepatch: 'test_klp_atomic_replace': initializing patching transition
[  251.780049] livepatch: 'test_klp_atomic_replace': starting patching transition
[  252.911301] livepatch: 'test_klp_atomic_replace': completing patching transition
[  252.912669] livepatch: 'test_klp_atomic_replace': patching complete
[  253.001881] test_klp_atomic_replace: this has been live patched
[  253.002864] % rmmod test_klp_livepatch
[  253.052447] test_klp_atomic_replace: this has been live patched
[  253.052561] % echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
[  253.052580] livepatch: 'test_klp_atomic_replace': initializing unpatching transition
[  253.052597] livepatch: 'test_klp_atomic_replace': starting unpatching transition
[  253.871341] livepatch: 'test_klp_atomic_replace': completing unpatching transition
[  253.872934] livepatch: 'test_klp_atomic_replace': unpatching complete
[  253.961071] % rmmod test_klp_atomic_replace
[  254.075347] livepatch: kernel.ftrace_enabled = 1
[  254.083375] ===== TEST: target module before livepatch =====
[  254.086470] % modprobe test_klp_callbacks_mod
[  254.087750] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  254.091112] % modprobe test_klp_callbacks_demo
[  254.092572] livepatch: enabling patch 'test_klp_callbacks_demo'
[  254.092574] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  254.092593] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  254.092594] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  254.092595] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  254.911372] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  254.911470] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  254.911472] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  254.911474] livepatch: 'test_klp_callbacks_demo': patching complete
[  255.008950] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  255.008969] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  255.009000] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  255.009002] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  255.009020] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  255.951355] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  255.951452] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  255.951454] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  255.951456] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  256.018607] % rmmod test_klp_callbacks_demo
[  256.091916] % rmmod test_klp_callbacks_mod
[  256.093014] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  256.169237] ===== TEST: module_coming notifier =====
[  256.172297] % modprobe test_klp_callbacks_demo
[  256.173751] livepatch: enabling patch 'test_klp_callbacks_demo'
[  256.173753] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  256.173772] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  256.173774] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  257.871420] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  257.871550] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  257.871552] livepatch: 'test_klp_callbacks_demo': patching complete
[  257.906694] % modprobe test_klp_callbacks_mod
[  257.907956] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  257.907958] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  257.907959] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  257.907977] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  257.908350] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  257.908367] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  257.908387] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  257.908388] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  257.908390] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  258.911396] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  258.911552] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  258.911554] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  258.911556] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  258.918270] % rmmod test_klp_callbacks_demo
[  259.001970] % rmmod test_klp_callbacks_mod
[  259.002953] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  259.118512] ===== TEST: module_going notifier =====
[  259.121469] % modprobe test_klp_callbacks_mod
[  259.122753] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  259.125852] % modprobe test_klp_callbacks_demo
[  259.127258] livepatch: enabling patch 'test_klp_callbacks_demo'
[  259.127259] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  259.127280] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  259.127281] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  259.127282] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  260.191345] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  260.191448] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  260.191449] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[  260.191451] livepatch: 'test_klp_callbacks_demo': patching complete
[  260.248083] % rmmod test_klp_callbacks_mod
[  260.249312] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  260.249330] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  260.249332] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  260.249333] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  260.311104] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  260.311123] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  260.311150] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  260.311151] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  261.151436] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  261.151581] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  261.151583] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  261.220008] % rmmod test_klp_callbacks_demo
[  261.309304] ===== TEST: module_coming and module_going notifiers =====
[  261.312251] % modprobe test_klp_callbacks_demo
[  261.313722] livepatch: enabling patch 'test_klp_callbacks_demo'
[  261.313724] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  261.313762] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  261.313763] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  262.671500] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  262.671624] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  262.671626] livepatch: 'test_klp_callbacks_demo': patching complete
[  262.742090] % modprobe test_klp_callbacks_mod
[  262.743321] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  262.743324] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  262.743326] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  262.743344] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  262.744479] % rmmod test_klp_callbacks_mod
[  262.745567] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  262.745582] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  262.745584] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  262.745585] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  262.811091] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  262.811109] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  262.811130] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  262.811131] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  263.951430] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  263.951537] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  263.951539] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  264.022343] % rmmod test_klp_callbacks_demo
[  264.179776] ===== TEST: target module not present =====
[  264.182883] % modprobe test_klp_callbacks_demo
[  264.184345] livepatch: enabling patch 'test_klp_callbacks_demo'
[  264.184347] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  264.184367] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  264.184368] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  265.081369] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  265.081514] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  265.081516] livepatch: 'test_klp_callbacks_demo': patching complete
[  265.101043] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  265.101062] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  265.101083] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  265.101084] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  266.191411] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  266.191510] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  266.191512] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  266.211817] % rmmod test_klp_callbacks_demo
[  266.279575] ===== TEST: pre-patch callback -ENODEV =====
[  266.282491] % modprobe test_klp_callbacks_mod
[  266.283760] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  266.284111] % modprobe test_klp_callbacks_demo pre_patch_ret=-19
[  266.285525] livepatch: enabling patch 'test_klp_callbacks_demo'
[  266.285527] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  266.285548] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  266.285549] livepatch: pre-patch callback failed for object 'vmlinux'
[  266.285550] livepatch: failed to enable patch 'test_klp_callbacks_demo'
[  266.285551] livepatch: 'test_klp_callbacks_demo': canceling patching transition, going to unpatch
[  266.285552] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  266.285659] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  266.481071] modprobe: ERROR: could not insert 'test_klp_callbacks_demo': No such device
[  266.482054] % rmmod test_klp_callbacks_mod
[  266.483170] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  266.569358] ===== TEST: module_coming + pre-patch callback -ENODEV =====
[  266.572523] % modprobe test_klp_callbacks_demo
[  266.573921] livepatch: enabling patch 'test_klp_callbacks_demo'
[  266.573924] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  266.573963] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  266.573965] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  268.031434] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  268.031535] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  268.031537] livepatch: 'test_klp_callbacks_demo': patching complete
[  268.100668] % echo -19 > /sys/module/test_klp_callbacks_demo/parameters/pre_patch_ret
[  268.101662] % modprobe test_klp_callbacks_mod
[  268.102985] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  268.102988] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  268.102990] livepatch: pre-patch callback failed for object 'test_klp_callbacks_mod'
[  268.102991] livepatch: patch 'test_klp_callbacks_demo' failed for module 'test_klp_callbacks_mod', refusing to load module 'test_klp_callbacks_mod'
[  268.231087] modprobe: ERROR: could not insert 'test_klp_callbacks_mod': No such device
[  268.231141] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  268.231156] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  268.231176] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  268.231177] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  269.951417] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  269.951520] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  269.951522] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  270.048128] % rmmod test_klp_callbacks_demo
[  270.110260] ===== TEST: multiple target modules =====
[  270.113377] % modprobe test_klp_callbacks_busy block_transition=N
[  270.114847] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  270.114851] test_klp_callbacks_busy: busymod_work_func enter
[  270.114853] test_klp_callbacks_busy: busymod_work_func exit
[  270.118456] % modprobe test_klp_callbacks_demo
[  270.119920] livepatch: enabling patch 'test_klp_callbacks_demo'
[  270.119922] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  270.119941] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  270.119943] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  270.121350] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  271.871484] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  271.871585] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  271.871587] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  271.871589] livepatch: 'test_klp_callbacks_demo': patching complete
[  271.957226] % modprobe test_klp_callbacks_mod
[  271.958646] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  271.958665] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  271.958667] test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  271.958683] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  271.960010] % rmmod test_klp_callbacks_mod
[  271.961127] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  271.961141] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  271.961143] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  271.961145] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  272.031267] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  272.031285] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  272.031303] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  272.031304] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  272.031306] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  272.831467] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  272.833230] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  272.833232] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  272.833233] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  272.839688] % rmmod test_klp_callbacks_demo
[  272.912113] % rmmod test_klp_callbacks_busy
[  272.913268] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  272.989731] ===== TEST: busy target module =====
[  272.992863] % modprobe test_klp_callbacks_busy block_transition=Y
[  272.994427] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  272.994433] test_klp_callbacks_busy: busymod_work_func enter
[  272.997897] % modprobe test_klp_callbacks_demo
[  272.999390] livepatch: enabling patch 'test_klp_callbacks_demo'
[  272.999391] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  272.999413] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  272.999415] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  273.000863] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  273.006166] % modprobe test_klp_callbacks_mod
[  273.007622] livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
[  273.007624] test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
[  273.007651] test_klp_callbacks_mod: test_klp_callbacks_mod_init
[  273.009014] % rmmod test_klp_callbacks_mod
[  273.010123] test_klp_callbacks_mod: test_klp_callbacks_mod_exit
[  273.010139] livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
[  273.010141] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
[  273.091251] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  273.091269] livepatch: 'test_klp_callbacks_demo': reversing transition from patching to unpatching
[  273.091425] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  275.791451] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  275.793206] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  275.793209] test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_busy -> [MODULE_STATE_LIVE] Normal state
[  275.793210] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  275.815309] % rmmod test_klp_callbacks_demo
[  275.882051] % rmmod test_klp_callbacks_busy
[  275.890764] test_klp_callbacks_busy: busymod_work_func exit
[  275.890773] test_klp_callbacks_busy: test_klp_callbacks_busy_exit
[  275.959816] ===== TEST: multiple livepatches =====
[  275.963029] % modprobe test_klp_callbacks_demo
[  275.964604] livepatch: enabling patch 'test_klp_callbacks_demo'
[  275.964606] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  275.964628] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  275.964629] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  277.641504] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  277.641611] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  277.641613] livepatch: 'test_klp_callbacks_demo': patching complete
[  277.698468] % modprobe test_klp_callbacks_demo2
[  277.700098] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  277.700100] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  277.700119] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  277.700120] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  278.681475] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  278.681615] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  278.681617] livepatch: 'test_klp_callbacks_demo2': patching complete
[  278.719462] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  278.719482] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  278.719504] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  278.719505] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  279.791389] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  279.791487] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  279.791489] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  279.829592] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
[  279.829612] livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
[  279.829629] test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
[  279.829630] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
[  280.831497] livepatch: 'test_klp_callbacks_demo': completing unpatching transition
[  280.831602] test_klp_callbacks_demo: post_unpatch_callback: vmlinux
[  280.831604] livepatch: 'test_klp_callbacks_demo': unpatching complete
[  280.839540] % rmmod test_klp_callbacks_demo2
[  280.912127] % rmmod test_klp_callbacks_demo
[  280.989065] ===== TEST: atomic replace =====
[  280.991951] % modprobe test_klp_callbacks_demo
[  280.993414] livepatch: enabling patch 'test_klp_callbacks_demo'
[  280.993416] livepatch: 'test_klp_callbacks_demo': initializing patching transition
[  280.993436] test_klp_callbacks_demo: pre_patch_callback: vmlinux
[  280.993437] livepatch: 'test_klp_callbacks_demo': starting patching transition
[  281.871479] livepatch: 'test_klp_callbacks_demo': completing patching transition
[  281.871579] test_klp_callbacks_demo: post_patch_callback: vmlinux
[  281.871581] livepatch: 'test_klp_callbacks_demo': patching complete
[  281.912919] % modprobe test_klp_callbacks_demo2 replace=1
[  281.914353] livepatch: enabling patch 'test_klp_callbacks_demo2'
[  281.914356] livepatch: 'test_klp_callbacks_demo2': initializing patching transition
[  281.914376] test_klp_callbacks_demo2: pre_patch_callback: vmlinux
[  281.914377] livepatch: 'test_klp_callbacks_demo2': starting patching transition
[  283.071478] livepatch: 'test_klp_callbacks_demo2': completing patching transition
[  283.071583] test_klp_callbacks_demo2: post_patch_callback: vmlinux
[  283.071585] livepatch: 'test_klp_callbacks_demo2': patching complete
[  283.135341] % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo2/enabled
[  283.135361] livepatch: 'test_klp_callbacks_demo2': initializing unpatching transition
[  283.135381] test_klp_callbacks_demo2: pre_unpatch_callback: vmlinux
[  283.135382] livepatch: 'test_klp_callbacks_demo2': starting unpatching transition
[  284.031462] livepatch: 'test_klp_callbacks_demo2': completing unpatching transition
[  284.031579] test_klp_callbacks_demo2: post_unpatch_callback: vmlinux
[  284.031580] livepatch: 'test_klp_callbacks_demo2': unpatching complete
[  284.044328] % rmmod test_klp_callbacks_demo2
[  284.112113] % rmmod test_klp_callbacks_demo
[  284.224335] livepatch: kernel.ftrace_enabled = 1
[  284.232921] ===== TEST: basic shadow variable API =====
[  284.235963] % modprobe test_klp_shadow_vars
[  284.237528] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  284.237531] test_klp_shadow_vars:   got expected NULL result
[  284.237533] test_klp_shadow_vars: shadow_ctor: PTR3 -> PTR2
[  284.237535] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  284.237538] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
[  284.237539] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
[  284.237542] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
[  284.237543] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  284.237545] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10
[  284.237547] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR10 = PTR11
[  284.237549] test_klp_shadow_vars: shadow_ctor: PTR13 -> PTR12
[  284.237550] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  284.237553] test_klp_shadow_vars: shadow_ctor: PTR16 -> PTR15
[  284.237554] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR14, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR15 = PTR16
[  284.237556] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR3
[  284.237558] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  284.237559] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  284.237561] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  284.237562] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  284.237564] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  284.237565] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  284.237566] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  284.237567] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR13
[  284.237569] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  284.237570] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  284.237571] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  284.237573] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
[  284.237575] test_klp_shadow_vars:   got expected PTR3 -> PTR2 result
[  284.237576] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
[  284.237579] test_klp_shadow_vars:   got expected PTR8 -> PTR7 result
[  284.237580] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR14, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR12 = PTR13
[  284.237582] test_klp_shadow_vars:   got expected PTR13 -> PTR12 result
[  284.237583] test_klp_shadow_vars: shadow_dtor(obj=PTR1, shadow_data=PTR3)
[  284.237585] test_klp_shadow_vars: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR17)
[  284.237587] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
[  284.237588] test_klp_shadow_vars:   got expected NULL result
[  284.237589] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  284.237590] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR17)
[  284.237592] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  284.237593] test_klp_shadow_vars:   got expected NULL result
[  284.237594] test_klp_shadow_vars: shadow_dtor(obj=PTR14, shadow_data=PTR13)
[  284.237596] test_klp_shadow_vars: klp_shadow_free(obj=PTR14, id=0x1234, dtor=PTR17)
[  284.237597] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1234) = PTR0
[  284.237598] test_klp_shadow_vars:   got expected NULL result
[  284.237599] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
[  284.237601] test_klp_shadow_vars:   got expected PTR6 -> PTR5 result
[  284.237602] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR11
[  284.237603] test_klp_shadow_vars:   got expected PTR11 -> PTR10 result
[  284.237604] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR16
[  284.237606] test_klp_shadow_vars:   got expected PTR16 -> PTR15 result
[  284.237615] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR0)
[  284.237616] test_klp_shadow_vars: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
[  284.237617] test_klp_shadow_vars:   got expected NULL result
[  284.237618] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1235) = PTR0
[  284.237620] test_klp_shadow_vars:   got expected NULL result
[  284.237620] test_klp_shadow_vars: klp_shadow_get(obj=PTR14, id=0x1235) = PTR0
[  284.237622] test_klp_shadow_vars:   got expected NULL result
[  284.238829] % rmmod test_klp_shadow_vars

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-saved1-rep.txt"

[   98.820331] livepatch: 'test_klp_state2': starting patching transition
[  100.031067] livepatch: 'test_klp_state2': completing patching transition
[  284.224335] livepatch: kernel.ftrace_enabled = 1

--Acs5g1P4J2zG/GLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg1-rep.txt"

[  100.031067] livepatch: 'test_klp_state2': completing patching transition
[  284.224335] livepatch: kernel.ftrace_enabled = 1
[  284.232921] ===== TEST: basic shadow variable API =====

--Acs5g1P4J2zG/GLh--


