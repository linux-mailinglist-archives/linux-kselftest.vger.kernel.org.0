Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCD406B20
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Sep 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhIJMDp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Sep 2021 08:03:45 -0400
Received: from ipmail06.adl3.internode.on.net ([150.101.137.16]:39194 "EHLO
        ipmail06.adl3.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232873AbhIJMDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Sep 2021 08:03:44 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 08:03:43 EDT
X-SMTP-MATCH: 1
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aoe8EfqPIzcoce8BcTtejsMiBIKoaSvp037?=
 =?us-ascii?q?Eqv3ocdfUzSL38qynOpoV46faasl0ssR0b8+xofZPgfZq+z+8X3WByB9eftW?=
 =?us-ascii?q?Dd0QOVxepZgrcKrQeMJ8SzzIBg6Zs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2B8AQB/RzthAEWNfAENTR4BAQsSDEA?=
 =?us-ascii?q?JgUULgXaBLIFChEeCXqo7gXwLAT4UBAEBhHABAoJEJjYHDgECBBUBAQYBAQE?=
 =?us-ascii?q?BAQYEEAE9VoVohlIBAyNWKA0CJgJZFIJ2AbNDeoExG2eIFIFjgRAqgWWHf4Q?=
 =?us-ascii?q?YN4FVRIEVJw8NgjeFEAEBbYJKNoIMIgSHQYEbL2iBY5FyjG6CC4Epm0stB4M?=
 =?us-ascii?q?ugTEGC4h+lCQsg2aLZ4YrA4tdhS2GeZFBniqGdwGCDTMaLm8Bgj4JSI5UFhW?=
 =?us-ascii?q?IT4VaZDgCBgsBAQMJj2ZeAQE?=
Received: from unknown (HELO [127.0.0.1]) ([1.124.141.69])
  by ipmail06.adl3.internode.on.net with ESMTP; 10 Sep 2021 21:27:26 +0930
Date:   Fri, 10 Sep 2021 21:27:23 +0930
From:   Arthur Marsh <arthur.marsh@internode.on.net>
To:     skhan@linuxfoundation.org
CC:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?After_KUnit_update_for_Linux_5=2E15-rc1_-_?= =?US-ASCII?Q?unable_to_share_VFAT_filesystem_via_samba?=
User-Agent: K-9 Mail for Android
In-Reply-To: 
Message-ID: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


 Hi, I have been sharing an old VFAT formatted hard disk on one pc to
another using Samba and sometime after kernel 5.14.0 it stopped working (apparently no longer being shared as the mount.smbfs command
on the client failed with error -13 yet mount.smbfs still worked for
ext3 filesytems shared from the same machine which had the VFAT
filesystem).
 The only error I saw on the machine with the VFAT formatted hard disk
was the output of the mount command had truncated the name of the
mount to only include the first 4 characters of the base name of the
mount point. 
 e.g. when VFAT filesystem was mounted on /mnt/victoria, the output of
the mount command showed the filesytem mounted on /mnt/vict 

The kernel build used was i386 with gcc 11.2.0-4 using 

make - j2 menuconfig bindeb-pkg

.config available on request. 

 The git-bisect was:
victoria:/usr/src/linux# git bisect loggit bisect start '--' 'fs/fat'#
good: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14git bisect
good 7d2a07b769330c34b4deabeed939325c77a7ec2f# bad:
[a3fa7a101dcff93791d1b1bdb3affcad1410c8c1] Merge branches 'akpm' and
'akpm-hotfixes' (patches from Andrew)git bisect bad
a3fa7a101dcff93791d1b1bdb3affcad1410c8c1# good:
[edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba] block: move the bdi from
the request_queue to the gendiskgit bisect good
edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba# good:
[b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd] fat: Add KUnit tests for
checksums and timestampsgit bisect good
b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd# bad:
[c815f04ba94940fbc303a6ea9669e7da87f8e77d] Merge tag
'linux-kselftest-kunit-5.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftestgit
bisect bad c815f04ba94940fbc303a6ea9669e7da87f8e77d# first bad commit:
[c815f04ba94940fbc303a6ea9669e7da87f8e77d] Merge tag
'linux-kselftest-kunit-5.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest

amarsh04@victoria:~$ mount|grep vic/dev/sdb6 on /vict type vfat
(rw,relatime,uid=65534,gid=65534,fmask=0000,dmask=0000,allow_utime=0022,codepage=437,iocharset=utf8,shortname=mixed,errors=remount-ro)

Happy to run any further tests but kernel builds are slow on this machine (Pentium Dl. 

Arthur. 


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
