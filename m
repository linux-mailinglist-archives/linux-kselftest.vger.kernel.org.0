Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5B8AFAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfHMGNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:13:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34508 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHMGNR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:13:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68sYR010868;
        Tue, 13 Aug 2019 06:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=osSqMWHv28avjbTj6QcaJxUDRAMJ3ZlAiS9rfxGjYzg=;
 b=mrvvWwB63K3x6ci1kK59RNlfNDoSK9mftOK1pAIyD2sL4atlRNxTN4BALkRAAcF92x1C
 iunLyjenghtiqknMbUJGEWJ7uKhAJjttoqq07VTfMzcD2YNQJTfq0YUencNAzMFGSf4j
 nVWGsVA9g+Aq+QXkktYlU3vAf2NexVAr3Ud2ORkdTKr5E9Fi9eR/8nTJPqinN5VwztyE
 8pCZPIxk14S960O+PddvoyweoaLt+3FTRwb8gnO57t7lN3mJcjlRXEn7UXY6THAxw3Ku
 PUyEg0HLjR8kgGNYDL//MROvpkvGq1Q0ScC6XPNG4xj8a19Uw78U7Kxg7wEpQWxlcZCz IA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=osSqMWHv28avjbTj6QcaJxUDRAMJ3ZlAiS9rfxGjYzg=;
 b=geKy5hJ2TDNupb+fP/a2ESM5rZiqJx0vAaM/I8GC8WKJvGiulnpuj0AHfvgWB2STpf+n
 NcnhECINUsWxZVBlaYjq0foHIMNwehq+IhRdEGH3k9v0JcICVhUTfj/FDJ6gmnj/NXRr
 2HfzlSfysRayBA7Fn43jCctNZjMWBVCydUhzV30lKenfTF1k3ODWMtcp2mKSUaHgdDLE
 dv8G5OW0epmiMzRr3Wbn6BJJ75jwCzTc3+J3XiUgRCvbEumbPxyEgf3Vq6EoEBux3GJw
 nnxEI/LLWUonnj/DUj5n/gV8u8Em4rBdFX1Qbz3m98IG4XAgr5rhYFGYNBQ76ssq+rHx qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u9nbtc1df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:12:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67QY1096512;
        Tue, 13 Aug 2019 06:10:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u9m0ayd7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:10:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6Ass3025920;
        Tue, 13 Aug 2019 06:10:54 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:10:54 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 01/19] kbuild: Fixes to rules for host-cshlib and host-cxxshlib
Date:   Tue, 13 Aug 2019 08:09:16 +0200
Message-Id: <be2c361eac49ded2848b2a555b75e30cc3c24e71.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

C++ libraries interfacing to C APIs might sometimes need some glue
logic more easily written in C.
Allow a C++ library to also contain 0 or more C objects.

Also fix rules for both C and C++ shared libraries:
- C++ shared libraries depended on .c instead of .cc files
- Rules were referenced as -objs instead of the intended
  -cobjs and -cxxobjs following the pattern from hostprogs*.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 scripts/Makefile.host | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index b6a54bd..4e9bb21 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -46,8 +46,10 @@ host-cxxmulti	:= $(foreach m,$(__hostprogs),$(if $($(m)-cxxobjs),$(m)))
 host-cxxobjs	:= $(sort $(foreach m,$(host-cxxmulti),$($(m)-cxxobjs)))
 
 # Object (.o) files used by the shared libaries
-host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-objs))))
-host-cxxshobjs	:= $(sort $(foreach m,$(host-cxxshlib),$($(m:.so=-objs))))
+# Note: C++ libraries may contain both C and C++ objects, compiled differently:
+host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-cshobjs))))
+host-cshobjs	+= $(sort $(foreach m,$(host-cxxshlib),$($(m:.so=-cshobjs))))
+host-cxxshobjs	:= $(sort $(foreach m,$(host-cxxshlib),$($(m:.so=-cxxshobjs))))
 
 host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
 host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
@@ -130,14 +132,10 @@ quiet_cmd_host-cshobjs	= HOSTCC  -fPIC $@
 $(host-cshobjs): $(obj)/%.o: $(src)/%.c FORCE
 	$(call if_changed_dep,host-cshobjs)
 
-# Compile .c file, create position independent .o file
-# Note that plugin capable gcc versions can be either C or C++ based
-# therefore plugin source files have to be compilable in both C and C++ mode.
-# This is why a C++ compiler is invoked on a .c file.
-# host-cxxshobjs -> .o
+# Compile .cc (C++) file, create position independent .o file
 quiet_cmd_host-cxxshobjs	= HOSTCXX -fPIC $@
       cmd_host-cxxshobjs	= $(HOSTCXX) $(hostcxx_flags) -fPIC -c -o $@ $<
-$(host-cxxshobjs): $(obj)/%.o: $(src)/%.c FORCE
+$(host-cxxshobjs): $(obj)/%.o: $(src)/%.cc FORCE
 	$(call if_changed_dep,host-cxxshobjs)
 
 # Link a shared library, based on position independent .o files
@@ -154,7 +152,8 @@ $(call multi_depend, $(host-cshlib), .so, -objs)
 # *.o -> .so shared library (host-cxxshlib)
 quiet_cmd_host-cxxshlib	= HOSTLLD -shared $@
       cmd_host-cxxshlib	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
-			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
+			  $(addprefix $(obj)/,$($(@F:.so=-cshobjs))) \
+			  $(addprefix $(obj)/,$($(@F:.so=-cxxshobjs))) \
 			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
 $(host-cxxshlib): FORCE
 	$(call if_changed,host-cxxshlib)
-- 
git-series 0.9.1
