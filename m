Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54559A8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2019 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF1MUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jun 2019 08:20:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfF1MUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U/n/6ZEpmIDBKGHgrR9OrCg1XI8jaOd6KkEJu3TT/Vo=; b=KwxmZYFjGmbyENF4hFhJi+nI4Z
        g2lqxvcwRCBVtt+3l05WMtTzV6KdgYH/dJvXsp/t8Khz7tDROiFbRY1CL3Jb5zMXWhyWWP3RQRyaC
        J5Qps2v/MAmyw9FvO30bu2w/8FWRoMQwDiGRu8lxO4lVrW2ovV3pPeuYEeqmvg6T8BF+Cf7oqCTJx
        9ROS7hlfc08o5pAEofV5aIoxsFNNc1VnjyzxDECRPFftVIFJWeP4DZP33SFrjz7AxkQrf4jw18Abv
        ShXe69kHgu7U1qsuBXfWa8tSv/3OtfDB16G7iBfdHF/gwO0SWz6FPhrcTXuBl55FNk2D232NlGXxJ
        7trkSP+Q==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprw-0000AP-0F; Fri, 28 Jun 2019 12:20:45 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpru-00059n-36; Fri, 28 Jun 2019 09:20:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jikos@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 37/43] docs: blockdev: convert to ReST
Date:   Fri, 28 Jun 2019 09:20:33 -0300
Message-Id: <82c018d038ac46277da25b4ead77b2833b940cde.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename the blockdev documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

The drbd sub-directory contains some graphs and data flows.
Add those too to the documentation.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  18 +-
 ...structure-v9.txt => data-structure-v9.rst} |   6 +-
 Documentation/blockdev/drbd/figures.rst       |  28 +++
 .../blockdev/drbd/{README.txt => index.rst}   |  15 +-
 .../blockdev/{floppy.txt => floppy.rst}       |  88 ++++----
 Documentation/blockdev/index.rst              |  16 ++
 Documentation/blockdev/{nbd.txt => nbd.rst}   |   2 +-
 .../blockdev/{paride.txt => paride.rst}       | 194 +++++++++--------
 .../blockdev/{ramdisk.txt => ramdisk.rst}     |  55 ++---
 Documentation/blockdev/{zram.txt => zram.rst} | 195 ++++++++++++------
 MAINTAINERS                                   |   8 +-
 drivers/block/Kconfig                         |   8 +-
 drivers/block/floppy.c                        |   2 +-
 drivers/block/zram/Kconfig                    |   6 +-
 tools/testing/selftests/zram/README           |   2 +-
 15 files changed, 398 insertions(+), 245 deletions(-)
 rename Documentation/blockdev/drbd/{data-structure-v9.txt => data-structure-v9.rst} (94%)
 create mode 100644 Documentation/blockdev/drbd/figures.rst
 rename Documentation/blockdev/drbd/{README.txt => index.rst} (55%)
 rename Documentation/blockdev/{floppy.txt => floppy.rst} (81%)
 create mode 100644 Documentation/blockdev/index.rst
 rename Documentation/blockdev/{nbd.txt => nbd.rst} (96%)
 rename Documentation/blockdev/{paride.txt => paride.rst} (81%)
 rename Documentation/blockdev/{ramdisk.txt => ramdisk.rst} (84%)
 rename Documentation/blockdev/{zram.txt => zram.rst} (76%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92d335837c52..7ed94527a4a0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1249,7 +1249,7 @@
 			See also Documentation/fault-injection/.
 
 	floppy=		[HW]
-			See Documentation/blockdev/floppy.txt.
+			See Documentation/blockdev/floppy.rst.
 
 	force_pal_cache_flush
 			[IA-64] Avoid check_sal_cache_flush which may hang on
@@ -2247,7 +2247,7 @@
 	memblock=debug	[KNL] Enable memblock debug messages.
 
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy
-			See Documentation/blockdev/ramdisk.txt.
+			See Documentation/blockdev/ramdisk.rst.
 
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
@@ -3294,7 +3294,7 @@
 
 	pcd.		[PARIDE]
 			See header of drivers/block/paride/pcd.c.
-			See also Documentation/blockdev/paride.txt.
+			See also Documentation/blockdev/paride.rst.
 
 	pci=option[,option...]	[PCI] various PCI subsystem options.
 
@@ -3538,7 +3538,7 @@
 			needed on a platform with proper driver support.
 
 	pd.		[PARIDE]
-			See Documentation/blockdev/paride.txt.
+			See Documentation/blockdev/paride.rst.
 
 	pdcchassis=	[PARISC,HW] Disable/Enable PDC Chassis Status codes at
 			boot time.
@@ -3553,10 +3553,10 @@
 			and performance comparison.
 
 	pf.		[PARIDE]
-			See Documentation/blockdev/paride.txt.
+			See Documentation/blockdev/paride.rst.
 
 	pg.		[PARIDE]
-			See Documentation/blockdev/paride.txt.
+			See Documentation/blockdev/paride.rst.
 
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/x86/i386/IO-APIC.rst.
@@ -3668,7 +3668,7 @@
 
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.
-			See Documentation/blockdev/ramdisk.txt.
+			See Documentation/blockdev/ramdisk.rst.
 
 	psi=		[KNL] Enable or disable pressure stall information
 			tracking.
@@ -3690,7 +3690,7 @@
 	pstore.backend=	Specify the name of the pstore backend to use
 
 	pt.		[PARIDE]
-			See Documentation/blockdev/paride.txt.
+			See Documentation/blockdev/paride.rst.
 
 	pti=		[X86_64] Control Page Table Isolation of user and
 			kernel address spaces.  Disabling this feature
@@ -3719,7 +3719,7 @@
 			See Documentation/admin-guide/md.rst.
 
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
-			See Documentation/blockdev/ramdisk.txt.
+			See Documentation/blockdev/ramdisk.rst.
 
 	random.trust_cpu={on,off}
 			[KNL] Enable or disable trusting the use of the
diff --git a/Documentation/blockdev/drbd/data-structure-v9.txt b/Documentation/blockdev/drbd/data-structure-v9.rst
similarity index 94%
rename from Documentation/blockdev/drbd/data-structure-v9.txt
rename to Documentation/blockdev/drbd/data-structure-v9.rst
index 1e52a0e32624..66036b901644 100644
--- a/Documentation/blockdev/drbd/data-structure-v9.txt
+++ b/Documentation/blockdev/drbd/data-structure-v9.rst
@@ -1,3 +1,7 @@
+================================
+kernel data structure for DRBD-9
+================================
+
 This describes the in kernel data structure for DRBD-9. Starting with
 Linux v3.14 we are reorganizing DRBD to use this data structure.
 
@@ -10,7 +14,7 @@ device is represented by a block device locally.
 
 The DRBD objects are interconnected to form a matrix as depicted below; a
 drbd_peer_device object sits at each intersection between a drbd_device and a
-drbd_connection:
+drbd_connection::
 
   /--------------+---------------+.....+---------------\
   |   resource   |    device     |     |    device     |
diff --git a/Documentation/blockdev/drbd/figures.rst b/Documentation/blockdev/drbd/figures.rst
new file mode 100644
index 000000000000..3e3fd4b8a478
--- /dev/null
+++ b/Documentation/blockdev/drbd/figures.rst
@@ -0,0 +1,28 @@
+.. The here included files are intended to help understand the implementation
+
+Data flows that Relate some functions, and write packets
+========================================================
+
+.. kernel-figure:: DRBD-8.3-data-packets.svg
+    :alt:   DRBD-8.3-data-packets.svg
+    :align: center
+
+.. kernel-figure:: DRBD-data-packets.svg
+    :alt:   DRBD-data-packets.svg
+    :align: center
+
+
+Sub graphs of DRBD's state transitions
+======================================
+
+.. kernel-figure:: conn-states-8.dot
+    :alt:   conn-states-8.dot
+    :align: center
+
+.. kernel-figure:: disk-states-8.dot
+    :alt:   disk-states-8.dot
+    :align: center
+
+.. kernel-figure:: node-states-8.dot
+    :alt:   node-states-8.dot
+    :align: center
diff --git a/Documentation/blockdev/drbd/README.txt b/Documentation/blockdev/drbd/index.rst
similarity index 55%
rename from Documentation/blockdev/drbd/README.txt
rename to Documentation/blockdev/drbd/index.rst
index 627b0a1bf35e..68ecd5c113e9 100644
--- a/Documentation/blockdev/drbd/README.txt
+++ b/Documentation/blockdev/drbd/index.rst
@@ -1,4 +1,9 @@
+==========================================
+Distributed Replicated Block Device - DRBD
+==========================================
+
 Description
+===========
 
   DRBD is a shared-nothing, synchronously replicated block device. It
   is designed to serve as a building block for high availability
@@ -7,10 +12,8 @@ Description
 
   Please visit http://www.drbd.org to find out more.
 
-The here included files are intended to help understand the implementation
+.. toctree::
+   :maxdepth: 1
 
-DRBD-8.3-data-packets.svg, DRBD-data-packets.svg  
-  relates some functions, and write packets.
-
-conn-states-8.dot, disk-states-8.dot, node-states-8.dot
-  The sub graphs of DRBD's state transitions
+   data-structure-v9
+   figures
diff --git a/Documentation/blockdev/floppy.txt b/Documentation/blockdev/floppy.rst
similarity index 81%
rename from Documentation/blockdev/floppy.txt
rename to Documentation/blockdev/floppy.rst
index e2240f5ab64d..4a8f31cf4139 100644
--- a/Documentation/blockdev/floppy.txt
+++ b/Documentation/blockdev/floppy.rst
@@ -1,35 +1,37 @@
-This file describes the floppy driver.
+=============
+Floppy Driver
+=============
 
 FAQ list:
 =========
 
- A FAQ list may be found in the fdutils package (see below), and also
+A FAQ list may be found in the fdutils package (see below), and also
 at <http://fdutils.linux.lu/faq.html>.
 
 
 LILO configuration options (Thinkpad users, read this)
 ======================================================
 
- The floppy driver is configured using the 'floppy=' option in
+The floppy driver is configured using the 'floppy=' option in
 lilo. This option can be typed at the boot prompt, or entered in the
 lilo configuration file.
 
- Example: If your kernel is called linux-2.6.9, type the following line
-at the lilo boot prompt (if you have a thinkpad):
+Example: If your kernel is called linux-2.6.9, type the following line
+at the lilo boot prompt (if you have a thinkpad)::
 
  linux-2.6.9 floppy=thinkpad
 
 You may also enter the following line in /etc/lilo.conf, in the description
-of linux-2.6.9:
+of linux-2.6.9::
 
  append = "floppy=thinkpad"
 
- Several floppy related options may be given, example:
+Several floppy related options may be given, example::
 
  linux-2.6.9 floppy=daring floppy=two_fdc
  append = "floppy=daring floppy=two_fdc"
 
- If you give options both in the lilo config file and on the boot
+If you give options both in the lilo config file and on the boot
 prompt, the option strings of both places are concatenated, the boot
 prompt options coming last. That's why there are also options to
 restore the default behavior.
@@ -38,21 +40,23 @@ restore the default behavior.
 Module configuration options
 ============================
 
- If you use the floppy driver as a module, use the following syntax:
-modprobe floppy floppy="<options>"
+If you use the floppy driver as a module, use the following syntax::
 
-Example:
- modprobe floppy floppy="omnibook messages"
+	modprobe floppy floppy="<options>"
 
- If you need certain options enabled every time you load the floppy driver,
-you can put:
+Example::
 
- options floppy floppy="omnibook messages"
+	modprobe floppy floppy="omnibook messages"
+
+If you need certain options enabled every time you load the floppy driver,
+you can put::
+
+	options floppy floppy="omnibook messages"
 
 in a configuration file in /etc/modprobe.d/.
 
 
- The floppy driver related options are:
+The floppy driver related options are:
 
  floppy=asus_pci
 	Sets the bit mask to allow only units 0 and 1. (default)
@@ -70,8 +74,7 @@ in a configuration file in /etc/modprobe.d/.
 	Tells the floppy driver that you have only one floppy controller.
 	(default)
 
- floppy=two_fdc
- floppy=<address>,two_fdc
+ floppy=two_fdc / floppy=<address>,two_fdc
 	Tells the floppy driver that you have two floppy controllers.
 	The second floppy controller is assumed to be at <address>.
 	This option is not needed if the second controller is at address
@@ -84,8 +87,7 @@ in a configuration file in /etc/modprobe.d/.
  floppy=0,thinkpad
 	Tells the floppy driver that you don't have a Thinkpad.
 
- floppy=omnibook
- floppy=nodma
+ floppy=omnibook / floppy=nodma
 	Tells the floppy driver not to use Dma for data transfers.
 	This is needed on HP Omnibooks, which don't have a workable
 	DMA channel for the floppy driver. This option is also useful
@@ -144,14 +146,16 @@ in a configuration file in /etc/modprobe.d/.
 	described in the physical CMOS), or if your BIOS uses
 	non-standard CMOS types. The CMOS types are:
 
-		0 - Use the value of the physical CMOS
-		1 - 5 1/4 DD
-		2 - 5 1/4 HD
-		3 - 3 1/2 DD
-		4 - 3 1/2 HD
-		5 - 3 1/2 ED
-		6 - 3 1/2 ED
-	       16 - unknown or not installed
+	       ==  ==================================
+		0  Use the value of the physical CMOS
+		1  5 1/4 DD
+		2  5 1/4 HD
+		3  3 1/2 DD
+		4  3 1/2 HD
+		5  3 1/2 ED
+		6  3 1/2 ED
+	       16  unknown or not installed
+	       ==  ==================================
 
 	(Note: there are two valid types for ED drives. This is because 5 was
 	initially chosen to represent floppy *tapes*, and 6 for ED drives.
@@ -162,8 +166,7 @@ in a configuration file in /etc/modprobe.d/.
 	Print a warning message when an unexpected interrupt is received.
 	(default)
 
- floppy=no_unexpected_interrupts
- floppy=L40SX
+ floppy=no_unexpected_interrupts / floppy=L40SX
 	Don't print a message when an unexpected interrupt is received. This
 	is needed on IBM L40SX laptops in certain video modes. (There seems
 	to be an interaction between video and floppy. The unexpected
@@ -199,47 +202,54 @@ in a configuration file in /etc/modprobe.d/.
 	Sets the floppy DMA channel to <nr> instead of 2.
 
  floppy=slow
-	Use PS/2 stepping rate:
-	 " PS/2 floppies have much slower step rates than regular floppies.
+	Use PS/2 stepping rate::
+
+	   PS/2 floppies have much slower step rates than regular floppies.
 	   It's been recommended that take about 1/4 of the default speed
-	   in some more extreme cases."
+	   in some more extreme cases.
 
 
 Supporting utilities and additional documentation:
 ==================================================
 
- Additional parameters of the floppy driver can be configured at
+Additional parameters of the floppy driver can be configured at
 runtime. Utilities which do this can be found in the fdutils package.
 This package also contains a new version of mtools which allows to
 access high capacity disks (up to 1992K on a high density 3 1/2 disk!).
 It also contains additional documentation about the floppy driver.
 
 The latest version can be found at fdutils homepage:
+
  http://fdutils.linux.lu
 
 The fdutils releases can be found at:
+
  http://fdutils.linux.lu/download.html
+
  http://www.tux.org/pub/knaff/fdutils/
+
  ftp://metalab.unc.edu/pub/Linux/utils/disk-management/
 
 Reporting problems about the floppy driver
 ==========================================
 
- If you have a question or a bug report about the floppy driver, mail
+If you have a question or a bug report about the floppy driver, mail
 me at Alain.Knaff@poboxes.com . If you post to Usenet, preferably use
 comp.os.linux.hardware. As the volume in these groups is rather high,
 be sure to include the word "floppy" (or "FLOPPY") in the subject
 line.  If the reported problem happens when mounting floppy disks, be
 sure to mention also the type of the filesystem in the subject line.
 
- Be sure to read the FAQ before mailing/posting any bug reports!
+Be sure to read the FAQ before mailing/posting any bug reports!
 
- Alain
+Alain
 
 Changelog
 =========
 
-10-30-2004 :	Cleanup, updating, add reference to module configuration.
+10-30-2004 :
+		Cleanup, updating, add reference to module configuration.
 		James Nelson <james4765@gmail.com>
 
-6-3-2000 :	Original Document
+6-3-2000 :
+		Original Document
diff --git a/Documentation/blockdev/index.rst b/Documentation/blockdev/index.rst
new file mode 100644
index 000000000000..a9af6ed8b4aa
--- /dev/null
+++ b/Documentation/blockdev/index.rst
@@ -0,0 +1,16 @@
+:orphan:
+
+===========================
+The Linux RapidIO Subsystem
+===========================
+
+.. toctree::
+   :maxdepth: 1
+
+   floppy
+   nbd
+   paride
+   ramdisk
+   zram
+
+   drbd/index
diff --git a/Documentation/blockdev/nbd.txt b/Documentation/blockdev/nbd.rst
similarity index 96%
rename from Documentation/blockdev/nbd.txt
rename to Documentation/blockdev/nbd.rst
index db242ea2bce8..d78dfe559dcf 100644
--- a/Documentation/blockdev/nbd.txt
+++ b/Documentation/blockdev/nbd.rst
@@ -1,3 +1,4 @@
+==================================
 Network Block Device (TCP version)
 ==================================
 
@@ -28,4 +29,3 @@ max_part
 
 nbds_max
 	Number of block devices that should be initialized (default: 16).
-
diff --git a/Documentation/blockdev/paride.txt b/Documentation/blockdev/paride.rst
similarity index 81%
rename from Documentation/blockdev/paride.txt
rename to Documentation/blockdev/paride.rst
index ee6717e3771d..87b4278bf314 100644
--- a/Documentation/blockdev/paride.txt
+++ b/Documentation/blockdev/paride.rst
@@ -1,15 +1,17 @@
-
-		Linux and parallel port IDE devices
+===================================
+Linux and parallel port IDE devices
+===================================
 
 PARIDE v1.03   (c) 1997-8  Grant Guenther <grant@torque.net>
 
 1. Introduction
+===============
 
 Owing to the simplicity and near universality of the parallel port interface
 to personal computers, many external devices such as portable hard-disk,
 CD-ROM, LS-120 and tape drives use the parallel port to connect to their
 host computer.  While some devices (notably scanners) use ad-hoc methods
-to pass commands and data through the parallel port interface, most 
+to pass commands and data through the parallel port interface, most
 external devices are actually identical to an internal model, but with
 a parallel-port adapter chip added in.  Some of the original parallel port
 adapters were little more than mechanisms for multiplexing a SCSI bus.
@@ -28,47 +30,50 @@ were to open up a parallel port CD-ROM drive, for instance, one would
 find a standard ATAPI CD-ROM drive, a power supply, and a single adapter
 that interconnected a standard PC parallel port cable and a standard
 IDE cable.  It is usually possible to exchange the CD-ROM device with
-any other device using the IDE interface. 
+any other device using the IDE interface.
 
 The document describes the support in Linux for parallel port IDE
 devices.  It does not cover parallel port SCSI devices, "ditto" tape
-drives or scanners.  Many different devices are supported by the 
+drives or scanners.  Many different devices are supported by the
 parallel port IDE subsystem, including:
 
-	MicroSolutions backpack CD-ROM
-	MicroSolutions backpack PD/CD
-	MicroSolutions backpack hard-drives
-	MicroSolutions backpack 8000t tape drive
-	SyQuest EZ-135, EZ-230 & SparQ drives
-	Avatar Shark
-	Imation Superdisk LS-120
-	Maxell Superdisk LS-120
-	FreeCom Power CD 
-	Hewlett-Packard 5GB and 8GB tape drives
-	Hewlett-Packard 7100 and 7200 CD-RW drives
+	- MicroSolutions backpack CD-ROM
+	- MicroSolutions backpack PD/CD
+	- MicroSolutions backpack hard-drives
+	- MicroSolutions backpack 8000t tape drive
+	- SyQuest EZ-135, EZ-230 & SparQ drives
+	- Avatar Shark
+	- Imation Superdisk LS-120
+	- Maxell Superdisk LS-120
+	- FreeCom Power CD
+	- Hewlett-Packard 5GB and 8GB tape drives
+	- Hewlett-Packard 7100 and 7200 CD-RW drives
 
 as well as most of the clone and no-name products on the market.
 
 To support such a wide range of devices, PARIDE, the parallel port IDE
 subsystem, is actually structured in three parts.   There is a base
 paride module which provides a registry and some common methods for
-accessing the parallel ports.  The second component is a set of 
-high-level drivers for each of the different types of supported devices: 
+accessing the parallel ports.  The second component is a set of
+high-level drivers for each of the different types of supported devices:
 
+	===	=============
 	pd	IDE disk
 	pcd	ATAPI CD-ROM
 	pf	ATAPI disk
 	pt	ATAPI tape
 	pg	ATAPI generic
+	===	=============
 
 (Currently, the pg driver is only used with CD-R drives).
 
 The high-level drivers function according to the relevant standards.
 The third component of PARIDE is a set of low-level protocol drivers
 for each of the parallel port IDE adapter chips.  Thanks to the interest
-and encouragement of Linux users from many parts of the world, 
+and encouragement of Linux users from many parts of the world,
 support is available for almost all known adapter protocols:
 
+	====    ====================================== ====
         aten    ATEN EH-100                            (HK)
         bpck    Microsolutions backpack                (US)
         comm    DataStor (old-type) "commuter" adapter (TW)
@@ -83,9 +88,11 @@ support is available for almost all known adapter protocols:
 	ktti    KT Technology PHd adapter              (SG)
         on20    OnSpec 90c20                           (US)
         on26    OnSpec 90c26                           (US)
+	====    ====================================== ====
 
 
 2. Using the PARIDE subsystem
+=============================
 
 While configuring the Linux kernel, you may choose either to build
 the PARIDE drivers into your kernel, or to build them as modules.
@@ -94,10 +101,10 @@ In either case, you will need to select "Parallel port IDE device support"
 as well as at least one of the high-level drivers and at least one
 of the parallel port communication protocols.  If you do not know
 what kind of parallel port adapter is used in your drive, you could
-begin by checking the file names and any text files on your DOS 
+begin by checking the file names and any text files on your DOS
 installation floppy.  Alternatively, you can look at the markings on
 the adapter chip itself.  That's usually sufficient to identify the
-correct device.  
+correct device.
 
 You can actually select all the protocol modules, and allow the PARIDE
 subsystem to try them all for you.
@@ -105,8 +112,9 @@ subsystem to try them all for you.
 For the "brand-name" products listed above, here are the protocol
 and high-level drivers that you would use:
 
+	================	============	======	========
 	Manufacturer		Model		Driver	Protocol
-	
+	================	============	======	========
 	MicroSolutions		CD-ROM		pcd	bpck
 	MicroSolutions		PD drive	pf	bpck
 	MicroSolutions		hard-drive	pd	bpck
@@ -119,8 +127,10 @@ and high-level drivers that you would use:
 	Hewlett-Packard		5GB Tape	pt	epat
 	Hewlett-Packard		7200e (CD)	pcd	epat
 	Hewlett-Packard		7200e (CD-R)	pg	epat
+	================	============	======	========
 
 2.1  Configuring built-in drivers
+---------------------------------
 
 We recommend that you get to know how the drivers work and how to
 configure them as loadable modules, before attempting to compile a
@@ -143,7 +153,7 @@ protocol identification number and, for some devices, the drive's
 chain ID.  While your system is booting, a number of messages are
 displayed on the console.  Like all such messages, they can be
 reviewed with the 'dmesg' command.  Among those messages will be
-some lines like:
+some lines like::
 
 	paride: bpck registered as protocol 0
 	paride: epat registered as protocol 1
@@ -158,10 +168,10 @@ the last two digits of the drive's serial number (but read MicroSolutions'
 documentation about this).
 
 As an example, let's assume that you have a MicroSolutions PD/CD drive
-with unit ID number 36 connected to the parallel port at 0x378, a SyQuest 
-EZ-135 connected to the chained port on the PD/CD drive and also an 
-Imation Superdisk connected to port 0x278.  You could give the following 
-options on your boot command:
+with unit ID number 36 connected to the parallel port at 0x378, a SyQuest
+EZ-135 connected to the chained port on the PD/CD drive and also an
+Imation Superdisk connected to port 0x278.  You could give the following
+options on your boot command::
 
 	pd.drive0=0x378,1 pf.drive0=0x278,1 pf.drive1=0x378,0,36
 
@@ -169,24 +179,27 @@ In the last option, pf.drive1 configures device /dev/pf1, the 0x378
 is the parallel port base address, the 0 is the protocol registration
 number and 36 is the chain ID.
 
-Please note:  while PARIDE will work both with and without the 
+Please note:  while PARIDE will work both with and without the
 PARPORT parallel port sharing system that is included by the
 "Parallel port support" option, PARPORT must be included and enabled
 if you want to use chains of devices on the same parallel port.
 
 2.2  Loading and configuring PARIDE as modules
+----------------------------------------------
 
 It is much faster and simpler to get to understand the PARIDE drivers
-if you use them as loadable kernel modules.   
+if you use them as loadable kernel modules.
 
-Note 1:  using these drivers with the "kerneld" automatic module loading
-system is not recommended for beginners, and is not documented here.  
+Note 1:
+	using these drivers with the "kerneld" automatic module loading
+	system is not recommended for beginners, and is not documented here.
 
-Note 2:  if you build PARPORT support as a loadable module, PARIDE must
-also be built as loadable modules, and PARPORT must be loaded before the
-PARIDE modules.
+Note 2:
+	if you build PARPORT support as a loadable module, PARIDE must
+	also be built as loadable modules, and PARPORT must be loaded before
+	the PARIDE modules.
 
-To use PARIDE, you must begin by 
+To use PARIDE, you must begin by::
 
 	insmod paride
 
@@ -195,8 +208,8 @@ among other tasks.
 
 Then, load as many of the protocol modules as you think you might need.
 As you load each module, it will register the protocols that it supports,
-and print a log message to your kernel log file and your console. For 
-example:
+and print a log message to your kernel log file and your console. For
+example::
 
 	# insmod epat
 	paride: epat registered as protocol 0
@@ -205,22 +218,22 @@ example:
         paride: k971 registered as protocol 2
 
 Finally, you can load high-level drivers for each kind of device that
-you have connected.  By default, each driver will autoprobe for a single 
+you have connected.  By default, each driver will autoprobe for a single
 device, but you can support up to four similar devices by giving their
 individual co-ordinates when you load the driver.
 
 For example, if you had two no-name CD-ROM drives both using the
 KingByte KBIC-951A adapter, one on port 0x378 and the other on 0x3bc
-you could give the following command:
+you could give the following command::
 
 	# insmod pcd drive0=0x378,1 drive1=0x3bc,1
 
 For most adapters, giving a port address and protocol number is sufficient,
-but check the source files in linux/drivers/block/paride for more 
+but check the source files in linux/drivers/block/paride for more
 information.  (Hopefully someone will write some man pages one day !).
 
 As another example, here's what happens when PARPORT is installed, and
-a SyQuest EZ-135 is attached to port 0x378:
+a SyQuest EZ-135 is attached to port 0x378::
 
 	# insmod paride
 	paride: version 1.0 installed
@@ -237,46 +250,47 @@ Note that the last line is the output from the generic partition table
 scanner - in this case it reports that it has found a disk with one partition.
 
 2.3  Using a PARIDE device
+--------------------------
 
 Once the drivers have been loaded, you can access PARIDE devices in the
 same way as their traditional counterparts.  You will probably need to
 create the device "special files".  Here is a simple script that you can
-cut to a file and execute:
+cut to a file and execute::
 
-#!/bin/bash
-#
-# mkd -- a script to create the device special files for the PARIDE subsystem
-#
-function mkdev {
-  mknod $1 $2 $3 $4 ; chmod 0660 $1 ; chown root:disk $1
-}
-#
-function pd {
-  D=$( printf \\$( printf "x%03x" $[ $1 + 97 ] ) )
-  mkdev pd$D b 45 $[ $1 * 16 ]
-  for P in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
-  do mkdev pd$D$P b 45 $[ $1 * 16 + $P ]
-  done
-}
-#
-cd /dev
-#
-for u in 0 1 2 3 ; do pd $u ; done
-for u in 0 1 2 3 ; do mkdev pcd$u b 46 $u ; done 
-for u in 0 1 2 3 ; do mkdev pf$u  b 47 $u ; done 
-for u in 0 1 2 3 ; do mkdev pt$u  c 96 $u ; done 
-for u in 0 1 2 3 ; do mkdev npt$u c 96 $[ $u + 128 ] ; done 
-for u in 0 1 2 3 ; do mkdev pg$u  c 97 $u ; done 
-#
-# end of mkd
+  #!/bin/bash
+  #
+  # mkd -- a script to create the device special files for the PARIDE subsystem
+  #
+  function mkdev {
+    mknod $1 $2 $3 $4 ; chmod 0660 $1 ; chown root:disk $1
+  }
+  #
+  function pd {
+    D=$( printf \\$( printf "x%03x" $[ $1 + 97 ] ) )
+    mkdev pd$D b 45 $[ $1 * 16 ]
+    for P in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
+    do mkdev pd$D$P b 45 $[ $1 * 16 + $P ]
+    done
+  }
+  #
+  cd /dev
+  #
+  for u in 0 1 2 3 ; do pd $u ; done
+  for u in 0 1 2 3 ; do mkdev pcd$u b 46 $u ; done
+  for u in 0 1 2 3 ; do mkdev pf$u  b 47 $u ; done
+  for u in 0 1 2 3 ; do mkdev pt$u  c 96 $u ; done
+  for u in 0 1 2 3 ; do mkdev npt$u c 96 $[ $u + 128 ] ; done
+  for u in 0 1 2 3 ; do mkdev pg$u  c 97 $u ; done
+  #
+  # end of mkd
 
 With the device files and drivers in place, you can access PARIDE devices
-like any other Linux device.   For example, to mount a CD-ROM in pcd0, use:
+like any other Linux device.   For example, to mount a CD-ROM in pcd0, use::
 
 	mount /dev/pcd0 /cdrom
 
 If you have a fresh Avatar Shark cartridge, and the drive is pda, you
-might do something like:
+might do something like::
 
 	fdisk /dev/pda		-- make a new partition table with
 				   partition 1 of type 83
@@ -289,41 +303,46 @@ might do something like:
 
 Devices like the Imation superdisk work in the same way, except that
 they do not have a partition table.  For example to make a 120MB
-floppy that you could share with a DOS system:
+floppy that you could share with a DOS system::
 
 	mkdosfs /dev/pf0
 	mount /dev/pf0 /mnt
 
 
 2.4  The pf driver
+------------------
 
 The pf driver is intended for use with parallel port ATAPI disk
 devices.  The most common devices in this category are PD drives
 and LS-120 drives.  Traditionally, media for these devices are not
 partitioned.  Consequently, the pf driver does not support partitioned
-media.  This may be changed in a future version of the driver. 
+media.  This may be changed in a future version of the driver.
 
 2.5  Using the pt driver
+------------------------
 
 The pt driver for parallel port ATAPI tape drives is a minimal driver.
-It does not yet support many of the standard tape ioctl operations. 
+It does not yet support many of the standard tape ioctl operations.
 For best performance, a block size of 32KB should be used.  You will
 probably want to set the parallel port delay to 0, if you can.
 
 2.6  Using the pg driver
+------------------------
 
 The pg driver can be used in conjunction with the cdrecord program
 to create CD-ROMs.  Please get cdrecord version 1.6.1 or later
-from ftp://ftp.fokus.gmd.de/pub/unix/cdrecord/ .  To record CD-R media 
-your parallel port should ideally be set to EPP mode, and the "port delay" 
-should be set to 0.  With those settings it is possible to record at 2x 
+from ftp://ftp.fokus.gmd.de/pub/unix/cdrecord/ .  To record CD-R media
+your parallel port should ideally be set to EPP mode, and the "port delay"
+should be set to 0.  With those settings it is possible to record at 2x
 speed without any buffer underruns.  If you cannot get the driver to work
 in EPP mode, try to use "bidirectional" or "PS/2" mode and 1x speeds only.
 
 
 3. Troubleshooting
+==================
 
 3.1  Use EPP mode if you can
+----------------------------
 
 The most common problems that people report with the PARIDE drivers
 concern the parallel port CMOS settings.  At this time, none of the
@@ -332,6 +351,7 @@ If you are able to do so, please set your parallel port into EPP mode
 using your CMOS setup procedure.
 
 3.2  Check the port delay
+-------------------------
 
 Some parallel ports cannot reliably transfer data at full speed.  To
 offset the errors, the PARIDE protocol modules introduce a "port
@@ -347,23 +367,25 @@ read the comments at the beginning of the driver source files in
 linux/drivers/block/paride.
 
 3.3  Some drives need a printer reset
+-------------------------------------
 
 There appear to be a number of "noname" external drives on the market
 that do not always power up correctly.  We have noticed this with some
 drives based on OnSpec and older Freecom adapters.  In these rare cases,
 the adapter can often be reinitialised by issuing a "printer reset" on
-the parallel port.  As the reset operation is potentially disruptive in 
-multiple device environments, the PARIDE drivers will not do it 
-automatically.  You can however, force a printer reset by doing:
+the parallel port.  As the reset operation is potentially disruptive in
+multiple device environments, the PARIDE drivers will not do it
+automatically.  You can however, force a printer reset by doing::
 
 	insmod lp reset=1
 	rmmod lp
 
 If you have one of these marginal cases, you should probably build
 your paride drivers as modules, and arrange to do the printer reset
-before loading the PARIDE drivers. 
+before loading the PARIDE drivers.
 
 3.4  Use the verbose option and dmesg if you need help
+------------------------------------------------------
 
 While a lot of testing has gone into these drivers to make them work
 as smoothly as possible, problems will arise.  If you do have problems,
@@ -373,7 +395,7 @@ clues, then please make sure that only one drive is hooked to your system,
 and that either (a) PARPORT is enabled or (b) no other device driver
 is using your parallel port (check in /proc/ioports).  Then, load the
 appropriate drivers (you can load several protocol modules if you want)
-as in:
+as in::
 
 	# insmod paride
 	# insmod epat
@@ -394,12 +416,14 @@ by e-mail to grant@torque.net, or join the linux-parport mailing list
 and post your report there.
 
 3.5  For more information or help
+---------------------------------
 
 You can join the linux-parport mailing list by sending a mail message
-to 
+to:
+
 		linux-parport-request@torque.net
 
-with the single word 
+with the single word::
 
 		subscribe
 
@@ -412,6 +436,4 @@ have in your mail headers, when sending mail to the list server.
 You might also find some useful information on the linux-parport
 web pages (although they are not always up to date) at
 
-	http://web.archive.org/web/*/http://www.torque.net/parport/
-
-
+	http://web.archive.org/web/%2E/http://www.torque.net/parport/
diff --git a/Documentation/blockdev/ramdisk.txt b/Documentation/blockdev/ramdisk.rst
similarity index 84%
rename from Documentation/blockdev/ramdisk.txt
rename to Documentation/blockdev/ramdisk.rst
index 501e12e0323e..b7c2268f8dec 100644
--- a/Documentation/blockdev/ramdisk.txt
+++ b/Documentation/blockdev/ramdisk.rst
@@ -1,7 +1,8 @@
+==========================================
 Using the RAM disk block device with Linux
-------------------------------------------
+==========================================
 
-Contents:
+.. Contents:
 
 	1) Overview
 	2) Kernel Command Line Parameters
@@ -42,7 +43,7 @@ rescue floppy disk.
 2a) Kernel Command Line Parameters
 
 	ramdisk_size=N
-	==============
+		Size of the ramdisk.
 
 This parameter tells the RAM disk driver to set up RAM disks of N k size.  The
 default is 4096 (4 MB).
@@ -50,16 +51,13 @@ default is 4096 (4 MB).
 2b) Module parameters
 
 	rd_nr
-	=====
-	/dev/ramX devices created.
+		/dev/ramX devices created.
 
 	max_part
-	========
-	Maximum partition number.
+		Maximum partition number.
 
 	rd_size
-	=======
-	See ramdisk_size.
+		See ramdisk_size.
 
 3) Using "rdev -r"
 ------------------
@@ -71,11 +69,11 @@ to 2 MB (2^11) of where to find the RAM disk (this used to be the size). Bit
 prompt/wait sequence is to be given before trying to read the RAM disk. Since
 the RAM disk dynamically grows as data is being written into it, a size field
 is not required. Bits 11 to 13 are not currently used and may as well be zero.
-These numbers are no magical secrets, as seen below:
+These numbers are no magical secrets, as seen below::
 
-./arch/x86/kernel/setup.c:#define RAMDISK_IMAGE_START_MASK     0x07FF
-./arch/x86/kernel/setup.c:#define RAMDISK_PROMPT_FLAG          0x8000
-./arch/x86/kernel/setup.c:#define RAMDISK_LOAD_FLAG            0x4000
+  ./arch/x86/kernel/setup.c:#define RAMDISK_IMAGE_START_MASK     0x07FF
+  ./arch/x86/kernel/setup.c:#define RAMDISK_PROMPT_FLAG          0x8000
+  ./arch/x86/kernel/setup.c:#define RAMDISK_LOAD_FLAG            0x4000
 
 Consider a typical two floppy disk setup, where you will have the
 kernel on disk one, and have already put a RAM disk image onto disk #2.
@@ -92,20 +90,23 @@ sequence so that you have a chance to switch floppy disks.
 The command line equivalent is: "prompt_ramdisk=1"
 
 Putting that together gives 2^15 + 2^14 + 0 = 49152 for an rdev word.
-So to create disk one of the set, you would do:
+So to create disk one of the set, you would do::
 
 	/usr/src/linux# cat arch/x86/boot/zImage > /dev/fd0
 	/usr/src/linux# rdev /dev/fd0 /dev/fd0
 	/usr/src/linux# rdev -r /dev/fd0 49152
 
-If you make a boot disk that has LILO, then for the above, you would use:
+If you make a boot disk that has LILO, then for the above, you would use::
+
 	append = "ramdisk_start=0 load_ramdisk=1 prompt_ramdisk=1"
-Since the default start = 0 and the default prompt = 1, you could use:
+
+Since the default start = 0 and the default prompt = 1, you could use::
+
 	append = "load_ramdisk=1"
 
 
 4) An Example of Creating a Compressed RAM Disk
-----------------------------------------------
+-----------------------------------------------
 
 To create a RAM disk image, you will need a spare block device to
 construct it on. This can be the RAM disk device itself, or an
@@ -120,11 +121,11 @@ a) Decide on the RAM disk size that you want. Say 2 MB for this example.
    Create it by writing to the RAM disk device. (This step is not currently
    required, but may be in the future.) It is wise to zero out the
    area (esp. for disks) so that maximal compression is achieved for
-   the unused blocks of the image that you are about to create.
+   the unused blocks of the image that you are about to create::
 
 	dd if=/dev/zero of=/dev/ram0 bs=1k count=2048
 
-b) Make a filesystem on it. Say ext2fs for this example.
+b) Make a filesystem on it. Say ext2fs for this example::
 
 	mke2fs -vm0 /dev/ram0 2048
 
@@ -133,11 +134,11 @@ c) Mount it, copy the files you want to it (eg: /etc/* /dev/* ...)
 
 d) Compress the contents of the RAM disk. The level of compression
    will be approximately 50% of the space used by the files. Unused
-   space on the RAM disk will compress to almost nothing.
+   space on the RAM disk will compress to almost nothing::
 
 	dd if=/dev/ram0 bs=1k count=2048 | gzip -v9 > /tmp/ram_image.gz
 
-e) Put the kernel onto the floppy
+e) Put the kernel onto the floppy::
 
 	dd if=zImage of=/dev/fd0 bs=1k
 
@@ -146,13 +147,13 @@ f) Put the RAM disk image onto the floppy, after the kernel. Use an offset
    (possibly larger) kernel onto the same floppy later without overlapping
    the RAM disk image. An offset of 400 kB for kernels about 350 kB in
    size would be reasonable. Make sure offset+size of ram_image.gz is
-   not larger than the total space on your floppy (usually 1440 kB).
+   not larger than the total space on your floppy (usually 1440 kB)::
 
 	dd if=/tmp/ram_image.gz of=/dev/fd0 bs=1k seek=400
 
 g) Use "rdev" to set the boot device, RAM disk offset, prompt flag, etc.
    For prompt_ramdisk=1, load_ramdisk=1, ramdisk_start=400, one would
-   have 2^15 + 2^14 + 400 = 49552.
+   have 2^15 + 2^14 + 400 = 49552::
 
 	rdev /dev/fd0 /dev/fd0
 	rdev -r /dev/fd0 49552
@@ -160,15 +161,17 @@ g) Use "rdev" to set the boot device, RAM disk offset, prompt flag, etc.
 That is it. You now have your boot/root compressed RAM disk floppy. Some
 users may wish to combine steps (d) and (f) by using a pipe.
 
---------------------------------------------------------------------------
+
 						Paul Gortmaker 12/95
 
 Changelog:
 ----------
 
-10-22-04 :	Updated to reflect changes in command line options, remove
+10-22-04 :
+		Updated to reflect changes in command line options, remove
 		obsolete references, general cleanup.
 		James Nelson (james4765@gmail.com)
 
 
-12-95 :		Original Document
+12-95 :
+		Original Document
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.rst
similarity index 76%
rename from Documentation/blockdev/zram.txt
rename to Documentation/blockdev/zram.rst
index 4df0ce271085..2111231c9c0f 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.rst
@@ -1,7 +1,9 @@
+========================================
 zram: Compressed RAM based block devices
-----------------------------------------
+========================================
 
-* Introduction
+Introduction
+============
 
 The zram module creates RAM based block devices named /dev/zram<id>
 (<id> = 0, 1, ...). Pages written to these disks are compressed and stored
@@ -12,9 +14,11 @@ use as swap disks, various caches under /var and maybe many more :)
 Statistics for individual zram devices are exported through sysfs nodes at
 /sys/block/zram<id>/
 
-* Usage
+Usage
+=====
 
 There are several ways to configure and manage zram device(-s):
+
 a) using zram and zram_control sysfs attributes
 b) using zramctl utility, provided by util-linux (util-linux@vger.kernel.org).
 
@@ -22,7 +26,7 @@ In this document we will describe only 'manual' zram configuration steps,
 IOW, zram and zram_control sysfs attributes.
 
 In order to get a better idea about zramctl please consult util-linux
-documentation, zramctl man-page or `zramctl --help'. Please be informed
+documentation, zramctl man-page or `zramctl --help`. Please be informed
 that zram maintainers do not develop/maintain util-linux or zramctl, should
 you have any questions please contact util-linux@vger.kernel.org
 
@@ -30,19 +34,23 @@ Following shows a typical sequence of steps for using zram.
 
 WARNING
 =======
+
 For the sake of simplicity we skip error checking parts in most of the
 examples below. However, it is your sole responsibility to handle errors.
 
 zram sysfs attributes always return negative values in case of errors.
 The list of possible return codes:
--EBUSY	-- an attempt to modify an attribute that cannot be changed once
-the device has been initialised. Please reset device first;
--ENOMEM	-- zram was not able to allocate enough memory to fulfil your
-needs;
--EINVAL	-- invalid input has been provided.
+
+========  =============================================================
+-EBUSY	  an attempt to modify an attribute that cannot be changed once
+	  the device has been initialised. Please reset device first;
+-ENOMEM	  zram was not able to allocate enough memory to fulfil your
+	  needs;
+-EINVAL	  invalid input has been provided.
+========  =============================================================
 
 If you use 'echo', the returned value that is changed by 'echo' utility,
-and, in general case, something like:
+and, in general case, something like::
 
 	echo 3 > /sys/block/zram0/max_comp_streams
 	if [ $? -ne 0 ];
@@ -51,7 +59,11 @@ and, in general case, something like:
 
 should suffice.
 
-1) Load Module:
+1) Load Module
+==============
+
+::
+
 	modprobe zram num_devices=4
 	This creates 4 devices: /dev/zram{0,1,2,3}
 
@@ -59,6 +71,8 @@ num_devices parameter is optional and tells zram how many devices should be
 pre-created. Default: 1.
 
 2) Set max number of compression streams
+========================================
+
 Regardless the value passed to this attribute, ZRAM will always
 allocate multiple compression streams - one per online CPUs - thus
 allowing several concurrent compression operations. The number of
@@ -66,16 +80,20 @@ allocated compression streams goes down when some of the CPUs
 become offline. There is no single-compression-stream mode anymore,
 unless you are running a UP system or has only 1 CPU online.
 
-To find out how many streams are currently available:
+To find out how many streams are currently available::
+
 	cat /sys/block/zram0/max_comp_streams
 
 3) Select compression algorithm
+===============================
+
 Using comp_algorithm device attribute one can see available and
 currently selected (shown in square brackets) compression algorithms,
 change selected compression algorithm (once the device is initialised
 there is no way to change compression algorithm).
 
-Examples:
+Examples::
+
 	#show supported compression algorithms
 	cat /sys/block/zram0/comp_algorithm
 	lzo [lz4]
@@ -83,20 +101,23 @@ Examples:
 	#select lzo compression algorithm
 	echo lzo > /sys/block/zram0/comp_algorithm
 
-For the time being, the `comp_algorithm' content does not necessarily
+For the time being, the `comp_algorithm` content does not necessarily
 show every compression algorithm supported by the kernel. We keep this
 list primarily to simplify device configuration and one can configure
 a new device with a compression algorithm that is not listed in
-`comp_algorithm'. The thing is that, internally, ZRAM uses Crypto API
+`comp_algorithm`. The thing is that, internally, ZRAM uses Crypto API
 and, if some of the algorithms were built as modules, it's impossible
 to list all of them using, for instance, /proc/crypto or any other
 method. This, however, has an advantage of permitting the usage of
 custom crypto compression modules (implementing S/W or H/W compression).
 
 4) Set Disksize
+===============
+
 Set disk size by writing the value to sysfs node 'disksize'.
 The value can be either in bytes or you can use mem suffixes.
-Examples:
+Examples::
+
 	# Initialize /dev/zram0 with 50MB disksize
 	echo $((50*1024*1024)) > /sys/block/zram0/disksize
 
@@ -111,10 +132,13 @@ since we expect a 2:1 compression ratio. Note that zram uses about 0.1% of the
 size of the disk when not in use so a huge zram is wasteful.
 
 5) Set memory limit: Optional
+=============================
+
 Set memory limit by writing the value to sysfs node 'mem_limit'.
 The value can be either in bytes or you can use mem suffixes.
 In addition, you could change the value in runtime.
-Examples:
+Examples::
+
 	# limit /dev/zram0 with 50MB memory
 	echo $((50*1024*1024)) > /sys/block/zram0/mem_limit
 
@@ -126,7 +150,11 @@ Examples:
 	# To disable memory limit
 	echo 0 > /sys/block/zram0/mem_limit
 
-6) Activate:
+6) Activate
+===========
+
+::
+
 	mkswap /dev/zram0
 	swapon /dev/zram0
 
@@ -134,6 +162,7 @@ Examples:
 	mount /dev/zram1 /tmp
 
 7) Add/remove zram devices
+==========================
 
 zram provides a control interface, which enables dynamic (on-demand) device
 addition and removal.
@@ -142,37 +171,44 @@ In order to add a new /dev/zramX device, perform read operation on hot_add
 attribute. This will return either new device's device id (meaning that you
 can use /dev/zram<id>) or error code.
 
-Example:
+Example::
+
 	cat /sys/class/zram-control/hot_add
 	1
 
 To remove the existing /dev/zramX device (where X is a device id)
-execute
+execute::
+
 	echo X > /sys/class/zram-control/hot_remove
 
-8) Stats:
+8) Stats
+========
+
 Per-device statistics are exported as various nodes under /sys/block/zram<id>/
 
 A brief description of exported device attributes. For more details please
 read Documentation/ABI/testing/sysfs-block-zram.
 
+======================  ======  ===============================================
 Name            	access            description
-----            	------            -----------
+======================  ======  ===============================================
 disksize          	RW	show and set the device's disk size
 initstate         	RO	shows the initialization state of the device
 reset             	WO	trigger device reset
-mem_used_max      	WO	reset the `mem_used_max' counter (see later)
-mem_limit         	WO	specifies the maximum amount of memory ZRAM can use
-				to store the compressed data
-writeback_limit   	WO	specifies the maximum amount of write IO zram can
-				write out to backing device as 4KB unit
+mem_used_max      	WO	reset the `mem_used_max` counter (see later)
+mem_limit         	WO	specifies the maximum amount of memory ZRAM can
+				use to store the compressed data
+writeback_limit   	WO	specifies the maximum amount of write IO zram
+				can write out to backing device as 4KB unit
 writeback_limit_enable  RW	show and set writeback_limit feature
-max_comp_streams  	RW	the number of possible concurrent compress operations
+max_comp_streams  	RW	the number of possible concurrent compress
+				operations
 comp_algorithm    	RW	show and change the compression algorithm
 compact           	WO	trigger memory compaction
 debug_stat        	RO	this file is used for zram debugging purposes
 backing_dev	  	RW	set up backend storage for zram to write out
 idle		  	WO	mark allocated slot as idle
+======================  ======  ===============================================
 
 
 User space is advised to use the following files to read the device statistics.
@@ -188,23 +224,31 @@ The stat file represents device's I/O statistics not accounted by block
 layer and, thus, not available in zram<id>/stat file. It consists of a
 single line of text and contains the following stats separated by
 whitespace:
- failed_reads     the number of failed reads
- failed_writes    the number of failed writes
- invalid_io       the number of non-page-size-aligned I/O requests
+
+ =============    =============================================================
+ failed_reads     The number of failed reads
+ failed_writes    The number of failed writes
+ invalid_io       The number of non-page-size-aligned I/O requests
  notify_free      Depending on device usage scenario it may account
+
                   a) the number of pages freed because of swap slot free
-                  notifications or b) the number of pages freed because of
-                  REQ_OP_DISCARD requests sent by bio. The former ones are
-                  sent to a swap block device when a swap slot is freed,
-                  which implies that this disk is being used as a swap disk.
+                     notifications
+                  b) the number of pages freed because of
+                     REQ_OP_DISCARD requests sent by bio. The former ones are
+                     sent to a swap block device when a swap slot is freed,
+                     which implies that this disk is being used as a swap disk.
+
                   The latter ones are sent by filesystem mounted with
                   discard option, whenever some data blocks are getting
                   discarded.
+ =============    =============================================================
 
 File /sys/block/zram<id>/mm_stat
 
 The stat file represents device's mm statistics. It consists of a single
 line of text and contains the following stats separated by whitespace:
+
+ ================ =============================================================
  orig_data_size   uncompressed size of data stored in this disk.
 		  This excludes same-element-filled pages (same_pages) since
 		  no memory is allocated for them.
@@ -223,58 +267,71 @@ line of text and contains the following stats separated by whitespace:
                   No memory is allocated for such pages.
  pages_compacted  the number of pages freed during compaction
  huge_pages	  the number of incompressible pages
+ ================ =============================================================
 
 File /sys/block/zram<id>/bd_stat
 
 The stat file represents device's backing device statistics. It consists of
 a single line of text and contains the following stats separated by whitespace:
+
+ ============== =============================================================
  bd_count	size of data written in backing device.
 		Unit: 4K bytes
  bd_reads	the number of reads from backing device
 		Unit: 4K bytes
  bd_writes	the number of writes to backing device
 		Unit: 4K bytes
+ ============== =============================================================
+
+9) Deactivate
+=============
+
+::
 
-9) Deactivate:
 	swapoff /dev/zram0
 	umount /dev/zram1
 
-10) Reset:
-	Write any positive value to 'reset' sysfs node
-	echo 1 > /sys/block/zram0/reset
-	echo 1 > /sys/block/zram1/reset
+10) Reset
+=========
+
+	Write any positive value to 'reset' sysfs node::
+
+		echo 1 > /sys/block/zram0/reset
+		echo 1 > /sys/block/zram1/reset
 
 	This frees all the memory allocated for the given device and
 	resets the disksize to zero. You must set the disksize again
 	before reusing the device.
 
-* Optional Feature
+Optional Feature
+================
 
-= writeback
+writeback
+---------
 
 With CONFIG_ZRAM_WRITEBACK, zram can write idle/incompressible page
 to backing storage rather than keeping it in memory.
-To use the feature, admin should set up backing device via
+To use the feature, admin should set up backing device via::
 
-	"echo /dev/sda5 > /sys/block/zramX/backing_dev"
+	echo /dev/sda5 > /sys/block/zramX/backing_dev
 
 before disksize setting. It supports only partition at this moment.
-If admin want to use incompressible page writeback, they could do via
+If admin want to use incompressible page writeback, they could do via::
 
-	"echo huge > /sys/block/zramX/write"
+	echo huge > /sys/block/zramX/write
 
 To use idle page writeback, first, user need to declare zram pages
-as idle.
+as idle::
 
-	"echo all > /sys/block/zramX/idle"
+	echo all > /sys/block/zramX/idle
 
 From now on, any pages on zram are idle pages. The idle mark
 will be removed until someone request access of the block.
 IOW, unless there is access request, those pages are still idle pages.
 
-Admin can request writeback of those idle pages at right timing via
+Admin can request writeback of those idle pages at right timing via::
 
-	"echo idle > /sys/block/zramX/writeback"
+	echo idle > /sys/block/zramX/writeback
 
 With the command, zram writeback idle pages from memory to the storage.
 
@@ -285,7 +342,7 @@ to guarantee storage health for entire product life.
 To overcome the concern, zram supports "writeback_limit" feature.
 The "writeback_limit_enable"'s default value is 0 so that it doesn't limit
 any writeback. IOW, if admin want to apply writeback budget, he should
-enable writeback_limit_enable via
+enable writeback_limit_enable via::
 
 	$ echo 1 > /sys/block/zramX/writeback_limit_enable
 
@@ -296,7 +353,7 @@ until admin set the budget via /sys/block/zramX/writeback_limit.
 assigned via /sys/block/zramX/writeback_limit is meaninless.)
 
 If admin want to limit writeback as per-day 400M, he could do it
-like below.
+like below::
 
 	$ MB_SHIFT=20
 	$ 4K_SHIFT=12
@@ -305,16 +362,16 @@ like below.
 	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
 If admin want to allow further write again once the bugdet is exausted,
-he could do it like below
+he could do it like below::
 
 	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
 		/sys/block/zram0/writeback_limit
 
-If admin want to see remaining writeback budget since he set,
+If admin want to see remaining writeback budget since he set::
 
 	$ cat /sys/block/zramX/writeback_limit
 
-If admin want to disable writeback limit, he could do
+If admin want to disable writeback limit, he could do::
 
 	$ echo 0 > /sys/block/zramX/writeback_limit_enable
 
@@ -326,25 +383,35 @@ budget in next setting is user's job.
 If admin want to measure writeback count in a certain period, he could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
-= memory tracking
+memory tracking
+===============
 
 With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
 zram block. It could be useful to catch cold or incompressible
 pages of the process with*pagemap.
+
 If you enable the feature, you could see block state via
-/sys/kernel/debug/zram/zram0/block_state". The output is as follows,
+/sys/kernel/debug/zram/zram0/block_state". The output is as follows::
 
 	  300    75.033841 .wh.
 	  301    63.806904 s...
 	  302    63.806919 ..hi
 
-First column is zram's block index.
-Second column is access time since the system was booted
-Third column is state of the block.
-(s: same page
-w: written page to backing store
-h: huge page
-i: idle page)
+First column
+	zram's block index.
+Second column
+	access time since the system was booted
+Third column
+	state of the block:
+
+	s:
+		same page
+	w:
+		written page to backing store
+	h:
+		huge page
+	i:
+		idle page
 
 First line of above example says 300th block is accessed at 75.033841sec
 and the block's state is huge so it is written back to the backing
diff --git a/MAINTAINERS b/MAINTAINERS
index 85648a944446..808f65e06ad8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11024,7 +11024,7 @@ M:	Josef Bacik <josef@toxicpanda.com>
 S:	Maintained
 L:	linux-block@vger.kernel.org
 L:	nbd@other.debian.org
-F:	Documentation/blockdev/nbd.txt
+F:	Documentation/blockdev/nbd.rst
 F:	drivers/block/nbd.c
 F:	include/trace/events/nbd.h
 F:	include/uapi/linux/nbd.h
@@ -12028,7 +12028,7 @@ PARIDE DRIVERS FOR PARALLEL PORT IDE DEVICES
 M:	Tim Waugh <tim@cyberelk.net>
 L:	linux-parport@lists.infradead.org (subscribers-only)
 S:	Maintained
-F:	Documentation/blockdev/paride.txt
+F:	Documentation/blockdev/paride.rst
 F:	drivers/block/paride/
 
 PARISC ARCHITECTURE
@@ -13310,7 +13310,7 @@ F:	drivers/net/wireless/ralink/rt2x00/
 RAMDISK RAM BLOCK DEVICE DRIVER
 M:	Jens Axboe <axboe@kernel.dk>
 S:	Maintained
-F:	Documentation/blockdev/ramdisk.txt
+F:	Documentation/blockdev/ramdisk.rst
 F:	drivers/block/brd.c
 
 RANCHU VIRTUAL BOARD FOR MIPS
@@ -17672,7 +17672,7 @@ R:	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/block/zram/
-F:	Documentation/blockdev/zram.txt
+F:	Documentation/blockdev/zram.rst
 
 ZS DECSTATION Z85C30 SERIAL DRIVER
 M:	"Maciej W. Rozycki" <macro@linux-mips.org>
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 96ec7e0fc1ea..c43690b973d8 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -31,7 +31,7 @@ config BLK_DEV_FD
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
 	  Thinkpad users, is contained in
-	  <file:Documentation/blockdev/floppy.txt>.
+	  <file:Documentation/blockdev/floppy.rst>.
 	  That file also contains the location of the Floppy driver FAQ as
 	  well as location of the fdutils package used to configure additional
 	  parameters of the driver at run time.
@@ -96,7 +96,7 @@ config PARIDE
 	  your computer's parallel port. Most of them are actually IDE devices
 	  using a parallel port IDE adapter. This option enables the PARIDE
 	  subsystem which contains drivers for many of these external drives.
-	  Read <file:Documentation/blockdev/paride.txt> for more information.
+	  Read <file:Documentation/blockdev/paride.rst> for more information.
 
 	  If you have said Y to the "Parallel-port support" configuration
 	  option, you may share a single port between your printer and other
@@ -261,7 +261,7 @@ config BLK_DEV_NBD
 	  userland (making server and client physically the same computer,
 	  communicating using the loopback network device).
 
-	  Read <file:Documentation/blockdev/nbd.txt> for more information,
+	  Read <file:Documentation/blockdev/nbd.rst> for more information,
 	  especially about where to find the server code, which runs in user
 	  space and does not need special kernel support.
 
@@ -303,7 +303,7 @@ config BLK_DEV_RAM
 	  during the initial install of Linux.
 
 	  Note that the kernel command line option "ramdisk=XX" is now obsolete.
-	  For details, read <file:Documentation/blockdev/ramdisk.txt>.
+	  For details, read <file:Documentation/blockdev/ramdisk.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called brd. An alias "rd" has been defined
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b933a7eea52b..5c99e52f9dc1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4424,7 +4424,7 @@ static int __init floppy_setup(char *str)
 		pr_cont("\n");
 	} else
 		DPRINT("botched floppy option\n");
-	DPRINT("Read Documentation/blockdev/floppy.txt\n");
+	DPRINT("Read Documentation/blockdev/floppy.rst\n");
 	return 0;
 }
 
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 1ffc64770643..e06b99d54816 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -12,7 +12,7 @@ config ZRAM
 	  It has several use cases, for example: /tmp storage, use as swap
 	  disks and maybe many more.
 
-	  See Documentation/blockdev/zram.txt for more information.
+	  See Documentation/blockdev/zram.rst for more information.
 
 config ZRAM_WRITEBACK
        bool "Write back incompressible or idle page to backing device"
@@ -26,7 +26,7 @@ config ZRAM_WRITEBACK
 	 With /sys/block/zramX/{idle,writeback}, application could ask
 	 idle page's writeback to the backing device to save in memory.
 
-	 See Documentation/blockdev/zram.txt for more information.
+	 See Documentation/blockdev/zram.rst for more information.
 
 config ZRAM_MEMORY_TRACKING
 	bool "Track zRam block status"
@@ -36,4 +36,4 @@ config ZRAM_MEMORY_TRACKING
 	  of zRAM. Admin could see the information via
 	  /sys/kernel/debug/zram/zramX/block_state.
 
-	  See Documentation/blockdev/zram.txt for more information.
+	  See Documentation/blockdev/zram.rst for more information.
diff --git a/tools/testing/selftests/zram/README b/tools/testing/selftests/zram/README
index 7972cc512408..5fa378391d3b 100644
--- a/tools/testing/selftests/zram/README
+++ b/tools/testing/selftests/zram/README
@@ -37,4 +37,4 @@ Commands required for testing:
  - mkfs/ mkfs.ext4
 
 For more information please refer:
-kernel-source-tree/Documentation/blockdev/zram.txt
+kernel-source-tree/Documentation/blockdev/zram.rst
-- 
2.21.0

