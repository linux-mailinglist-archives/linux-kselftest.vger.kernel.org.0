Return-Path: <linux-kselftest+bounces-35737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF283AE7DFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BC616D43C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2AC29A9F5;
	Wed, 25 Jun 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HedyouSZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604429A32A;
	Wed, 25 Jun 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844835; cv=none; b=MqO5xgupc/8+ajA4F+d8IlZPZGAwD/Q1NsHRUDvAINqQKmXPpL6KrVB6nnhhE1t+0LNZNCplUsm/lK02h0moDltSbG4T6BG735rQWvjuuqiSRyZHG0f1Uf8OKpW1xb6kJRFoM2qJdcZJ+H/HzisCdQ/H96g8D2EWA8u9oJ5aYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844835; c=relaxed/simple;
	bh=IUNbPvytI6sSxYjGdH/2+FKF4YqW598gM5WxCp1EFCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxzS/th3Q+X02UOfU5zCtr4B80b2PxFLxPAaGmVYELZyYjrwgzT/Po4hUOpMv6p7oIBesHYnMnu8EybQjyzmpMHdR+1Z6SP7AZExiGPcqT2v3LLdDoC/LTJYbMrhMFRWXFZRAGGP7j8R2DB7zESxAYAMb/6yhCHYJ4FFBWRFE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HedyouSZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t4ZysQSFBfxYo16LI7Y4EY1oY84ZVNOVcKgo85fJhqs=; t=1750844832; x=1751449632; 
	b=HedyouSZQ5tJq2OJ4VloDbFER7mfpYJONwVw+w9IBHEQpXHal2SQ+AViMuRc/2UY4kqMhnWrf9G
	xOzYIiOXycN79y0gLyoHZ7gkUU/hz3V9Kb+LM8QMMlt9cQ9bVkuijBjWzDxHFMVI6SQxSq+j8/vN/
	M3ZFiFboaezBrVcMkPOIXNlgyYb2/N9Sixw8bmYaN5eSVtFhjcvN/4p0Z8eQDHqijh59xnjUuQlEE
	ORRpHYrDn/WfF6CsiWYU08QNY+KlYuXF43GgolEzJH0zScfYcyswMJmegd/Nl2djeUv5hJ3jn+HMc
	Vpmg4PUsXhmoK9QrIoU2T5SxC2QUVTxo4K8g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uUMic-000000000rq-14l5; Wed, 25 Jun 2025 11:47:02 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uUMib-00000001QAV-420T; Wed, 25 Jun 2025 11:47:02 +0200
Message-ID: <ff44b8bb790c9ff2997ea0a280eb4e2445675ab8.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/3] tools/nolibc: add support for SuperH
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Willy
 Tarreau <w@1wt.eu>,  Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 25 Jun 2025 11:47:01 +0200
In-Reply-To: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
References: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thomas,

On Mon, 2025-06-23 at 23:15 +0200, Thomas Wei=C3=9Fschuh wrote:
> Add support for SuperH/"sh" to nolibc.
> Only sh4 is tested for now.
>=20
> This is only tested on QEMU so far.
> Additional testing would be very welcome.
> Test instructions:
> $ cd tools/testings/selftests/nolibc/
> $ make -f Makefile.nolibc ARCH=3Dsh CROSS_COMPILE=3Dsh4-linux- nolibc-tes=
t
> $ file nolibc-test
> nolibc-test: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), sta=
tically linked, not stripped
> $ ./nolibc-test
> Running test 'startup'
> 0 argc =3D 1                                                        [OK]
> ...
> Total number of errors: 0
> Exiting with status 0

Here is the testrun of the nolibc-test on my SH7785LCR evaluation board:

glaubitz@tirpitz:/srv/glaubitz/linux-nolibc$ cat /proc/cpuinfo=20
machine         : SH7785LCR
processor       : 0
cpu family      : sh4a
cpu type        : SH7785
cut             : 7.x
cpu flags       : fpu perfctr llsc
cache type      : split (harvard)
icache size     : 32KiB (4-way)
dcache size     : 32KiB (4-way)
address sizes   : 32 bits physical
bogomips        : 599.99
glaubitz@tirpitz:/srv/glaubitz/linux-nolibc$ uname -a
Linux tirpitz.buildd.org 6.5.0-rc2 #1 PREEMPT Mon Jul 17 14:17:32 UTC 2023 =
sh4a GNU/Linux
glaubitz@tirpitz:/srv/glaubitz/linux-nolibc$ cd tools/testing/selftests/nol=
ibc/
glaubitz@tirpitz:/srv/glaubitz/linux-nolibc/tools/testing/selftests/nolibc$=
 make -f Makefile.nolibc ARCH=3Dsh nolibc-test
  MKDIR   sysroot/sh/include
make[1]: Entering directory '/srv/glaubitz/linux-nolibc'
make[2]: Nothing to be done for 'outputmakefile'.
make[1]: Leaving directory '/srv/glaubitz/linux-nolibc'
make[1]: Entering directory '/srv/glaubitz/linux-nolibc/tools/include/nolib=
c'
make[2]: Entering directory '/srv/glaubitz/linux-nolibc'
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/sh/include/generated/uapi/asm/ucontext.h
  WRAP    arch/sh/include/generated/uapi/asm/bitsperlong.h
  WRAP    arch/sh/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/sh/include/generated/uapi/asm/errno.h
  WRAP    arch/sh/include/generated/uapi/asm/fcntl.h
  WRAP    arch/sh/include/generated/uapi/asm/ioctl.h
  WRAP    arch/sh/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/sh/include/generated/uapi/asm/mman.h
(...)
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/poll.h
make[2]: Leaving directory '/srv/glaubitz/linux-nolibc'
make[2]: Entering directory '/srv/glaubitz/linux-nolibc'
  INSTALL /srv/glaubitz/linux-nolibc/tools/testing/selftests/nolibc/sysroot=
/sysroot/include
make[2]: Leaving directory '/srv/glaubitz/linux-nolibc'
make[1]: Leaving directory '/srv/glaubitz/linux-nolibc/tools/include/nolibc=
'
  CC      nolibc-test
In file included from sysroot/sh/include/arch.h:11,
                 from sysroot/sh/include/nolibc.h:96,
                 from sysroot/sh/include/stdio.h:8,
                 from nolibc-test.c:12:
sysroot/sh/include/crt.h:34:1: warning: =E2=80=98function=E2=80=99 attribut=
e directive ignored [-Wattributes]
   34 | {
      | ^
In file included from sysroot/sh/include/arch.h:11,
                 from sysroot/sh/include/nolibc.h:96,
                 from sysroot/sh/include/errno.h:8,
                 from nolibc-test-linkage.c:5:
sysroot/sh/include/crt.h:34:1: warning: =E2=80=98function=E2=80=99 attribut=
e directive ignored [-Wattributes]
   34 | {
      | ^
glaubitz@tirpitz:/srv/glaubitz/linux-nolibc/tools/testing/selftests/nolibc$
glaubitz@tirpitz:/srv/glaubitz/linux-nolibc/tools/testing/selftests/nolibc$=
 file ./nolibc-test
./nolibc-test: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), sta=
tically linked, BuildID[sha1]=3Db23b591a8deeb8b746636128821be1b577f3266b, n=
ot stripped
glaubitz@tirpitz:/srv/glaubitz/linux-nolibc/tools/testing/selftests/nolibc$=
 ./nolibc-test
Running test 'startup'
0 argc =3D 1                                                        [OK]
1 argv_addr =3D <0x7bd4b074>                                        [OK]
2 argv_environ =3D <0x7bd4b074>                                     [OK]
3 argv_total =3D 1                                                  [OK]
4 argv0_addr =3D <0x7bd4b1c2>                                       [OK]
5 argv0_str =3D <./nolibc-test>                                     [OK]
6 argv0_len =3D 13                                                  [OK]
7 environ_addr =3D <0x7bd4b07c>                                     [OK]
8 environ_envp =3D <0x7bd4b07c>                                     [OK]
9 environ_auxv =3D <0x7bd4b07c>                                     [OK]
10 environ_total =3D 111                                            [OK]
11 environ_HOME =3D <0x7bd4b672>                                    [OK]
12 auxv_addr =3D <0x7bd4b0ec>                                       [OK]
13 auxv_AT_UID =3D 1000                                             [OK]
14 constructor =3D 3                                                [OK]
15 linkage_errno =3D <0x42003c>                                     [OK]
16 linkage_constr =3D 3                                             [OK]
Errors during this test: 0

Running test 'syscall'
0 access =3D 0                                                      [OK]
1 access_bad =3D -1 EPERM                                           [OK]
2 clock_getres =3D 0                                                [OK]
3 clock_gettime =3D 0                                               [OK]
4 clock_settime =3D -1 EINVAL                                       [OK]
5 getpid =3D 24641                                                  [OK]
6 getppid =3D 17166                                                 [OK]
7 gettid =3D 24641                                                  [OK]
8 getpgid_self =3D 24641                                            [OK]
9 getpgid_bad =3D -1 ESRCH                                          [OK]
10 kill_0 =3D 0                                                     [OK]
11 kill_CONT =3D 0                                                  [OK]
12 kill_BADPID =3D -1 ESRCH                                         [OK]
13 sbrk_0 =3D <0x421000>                                            [OK]
14 sbrk =3D 0                                                       [OK]
15 brk =3D 0                                                        [OK]
16 chdir_root =3D 0                                                 [OK]
17 chdir_dot =3D 0                                                  [OK]
18 chdir_blah =3D -1 ENOENT                                         [OK]
19 chmod_argv0 =3D 0                                                [OK]
20 chmod_self =3D -1 EPERM                                          [OK]
21 chown_self =3D -1 EPERM                                          [OK]
22 chroot_root                                                  [SKIPPED]  =
=20
23 chroot_blah =3D -1 ENOENT                                        [OK]
24 chroot_exe =3D -1 ENOTDIR                                        [OK]
25 close_m1 =3D -1 EBADF                                            [OK]
26 close_dup =3D 0                                                  [OK]
27 dup_0 =3D 3                                                      [OK]
28 dup_m1 =3D -1 EBADF                                              [OK]
29 dup2_0 =3D 100                                                   [OK]
30 dup2_m1 =3D -1 EBADF                                             [OK]
31 dup3_0 =3D 100                                                   [OK]
32 dup3_m1 =3D -1 EBADF                                             [OK]
33 execve_root =3D -1 EACCES                                        [OK]
34 file_stream =3D 0                                                [OK]
35 fork =3D 0                                                       [OK]
36 getdents64_root =3D 944                                          [OK]
37 getdents64_null =3D -1 ENOTDIR                                   [OK]
38 directories =3D 0                                                [OK]
39 getrandom =3D 0                                                  [OK]
40 gettimeofday_tv =3D 0                                            [OK]
41 gettimeofday_tv_tz =3D 0                                         [OK]
42 getpagesize =3D 0                                                [OK]
43 ioctl_tiocinq =3D 0                                              [OK]
44 link_root1 =3D -1 EEXIST                                         [OK]
45 link_blah =3D -1 ENOENT                                          [OK]
46 link_dir                                                     [SKIPPED]  =
=20
47 link_cross =3D -1 EXDEV                                          [OK]
48 lseek_m1 =3D -1 EBADF                                            [OK]
49 lseek_0 =3D -1 ESPIPE                                            [OK]
50 mkdir_root =3D -1 EEXIST                                         [OK]
51 mmap_bad =3D <0xffffffff> EINVAL                                 [OK]
52 munmap_bad =3D -1 EINVAL                                         [OK]
53 mmap_munmap_good =3D 0                                           [OK]
54 open_tty =3D 3                                                   [OK]
55 open_blah =3D -1 ENOENT                                          [OK]
56 openat_dir =3D 0                                                 [OK]
57 pipe =3D 0                                                       [OK]
58 poll_null =3D 0                                                  [OK]
59 poll_stdout =3D 1                                                [OK]
60 poll_fault =3D -1 EFAULT                                         [OK]
61 prctl =3D -1 EFAULT                                              [OK]
62 read_badf =3D -1 EBADF                                           [OK]
63 rlimit =3D 0                                                     [OK]
64 rmdir_blah =3D -1 ENOENT                                         [OK]
65 sched_yield =3D 0                                                [OK]
66 select_null =3D 0                                                [OK]
67 select_stdout =3D 1                                              [OK]
68 select_fault =3D -1 EFAULT                                       [OK]
69 stat_blah =3D -1 ENOENT                                          [OK]
70 stat_fault =3D -1 EFAULT                                         [OK]
71 stat_timestamps =3D 0                                            [OK]
72 symlink_root =3D -1 EEXIST                                       [OK]
73 timer =3D 0                                                      [OK]
74 timerfd =3D 0                                                    [OK]
75 uname =3D 0                                                      [OK]
76 uname_fault =3D -1 EFAULT                                        [OK]
77 unlink_root =3D -1 EISDIR                                        [OK]
78 unlink_blah =3D -1 ENOENT                                        [OK]
79 wait_child =3D -1 ECHILD                                         [OK]
80 waitpid_min =3D -1 ESRCH                                         [OK]
81 waitpid_child =3D -1 ECHILD                                      [OK]
82 write_badf =3D -1 EBADF                                          [OK]
83 write_zero =3D 0                                                 [OK]
84 syscall_noargs =3D 24641                                         [OK]
85 syscall_args =3D -1 EFAULT                                       [OK]
86 namespace                                                    [SKIPPED]  =
=20
Errors during this test: 0

Running test 'stdlib'
0 getenv_TERM =3D <screen.xterm-256color>                           [OK]
1 getenv_blah =3D <(null)>                                          [OK]
2 setcmp_blah_blah =3D 0                                            [OK]
3 setcmp_blah_blah2 =3D -50                                         [OK]
4 setncmp_blah_blah =3D 0                                           [OK]
5 setncmp_blah_blah4 =3D 0                                          [OK]
6 setncmp_blah_blah5 =3D -53                                        [OK]
7 setncmp_blah_blah6 =3D -54                                        [OK]
8 strchr_foobar_o =3D <oobar>                                       [OK]
9 strchr_foobar_z =3D <(null)>                                      [OK]
10 strrchr_foobar_o =3D <obar>                                      [OK]
11 strrchr_foobar_z =3D <(null)>                                    [OK]
12 strlcat_0 =3D 3 <test>                                           [OK]
13 strlcat_1 =3D 4 <test>                                           [OK]
14 strlcat_5 =3D 7 <test>                                           [OK]
15 strlcat_6 =3D 7 <testb>                                          [OK]
16 strlcat_7 =3D 7 <testba>                                         [OK]
17 strlcat_8 =3D 7 <testbar>                                        [OK]
18 strlcpy_0 =3D 3 <test>                                           [OK]
19 strlcpy_1 =3D 3 <>                                               [OK]
20 strlcpy_2 =3D 3 <b>                                              [OK]
21 strlcpy_3 =3D 3 <ba>                                             [OK]
22 strlcpy_4 =3D 3 <bar>                                            [OK]
23 strstr_foobar_foo =3D <foobar>                                   [OK]
24 strstr_foobar_bar =3D <bar>                                      [OK]
25 strstr_foobar_baz =3D <0x0>                                      [OK]
26 memcmp_20_20 =3D 0                                               [OK]
27 memcmp_20_60 =3D -64                                             [OK]
28 memcmp_60_20 =3D 64                                              [OK]
29 memcmp_20_e0 =3D -192                                            [OK]
30 memcmp_e0_20 =3D 192                                             [OK]
31 memcmp_80_e0 =3D -96                                             [OK]
32 memcmp_e0_80 =3D 96                                              [OK]
33 limit_int8_max =3D 127                                           [OK]
34 limit_int8_min =3D -128                                          [OK]
35 limit_uint8_max =3D 255                                          [OK]
36 limit_int16_max =3D 32767                                        [OK]
37 limit_int16_min =3D -32768                                       [OK]
38 limit_uint16_max =3D 65535                                       [OK]
39 limit_int32_max =3D 2147483647                                   [OK]
40 limit_int32_min =3D -2147483648                                  [OK]
41 limit_uint32_max =3D 4294967295                                  [OK]
42 limit_int64_max =3D 9223372036854775807                          [OK]
43 limit_int64_min =3D -9223372036854775808                         [OK]
44 limit_uint64_max =3D -1                                          [OK]
45 limit_int_least8_max =3D 127                                     [OK]
46 limit_int_least8_min =3D -128                                    [OK]
47 limit_uint_least8_max =3D 255                                    [OK]
48 limit_int_least16_max =3D 32767                                  [OK]
49 limit_int_least16_min =3D -32768                                 [OK]
50 limit_uint_least16_max =3D 65535                                 [OK]
51 limit_int_least32_max =3D 2147483647                             [OK]
52 limit_int_least32_min =3D -2147483648                            [OK]
53 limit_uint_least32_max =3D 4294967295                            [OK]
54 limit_int_least64_min =3D -9223372036854775808                   [OK]
55 limit_int_least64_max =3D 9223372036854775807                    [OK]
56 limit_uint_least64_max =3D -1                                    [OK]
57 limit_int_fast8_max =3D 127                                      [OK]
58 limit_int_fast8_min =3D -128                                     [OK]
59 limit_uint_fast8_max =3D 255                                     [OK]
60 limit_int_fast16_min =3D -2147483648                             [OK]
61 limit_int_fast16_max =3D 2147483647                              [OK]
62 limit_uint_fast16_max =3D 4294967295                             [OK]
63 limit_int_fast32_min =3D -2147483648                             [OK]
64 limit_int_fast32_max =3D 2147483647                              [OK]
65 limit_uint_fast32_max =3D 4294967295                             [OK]
66 limit_int_fast64_min =3D -9223372036854775808                    [OK]
67 limit_int_fast64_max =3D 9223372036854775807                     [OK]
68 limit_uint_fast64_max =3D -1                                     [OK]
69 sizeof_long_sane =3D 1                                           [OK]
70 limit_intptr_min =3D -2147483648                                 [OK]
71 limit_intptr_max =3D 2147483647                                  [OK]
72 limit_uintptr_max =3D 4294967295                                 [OK]
73 limit_ptrdiff_min =3D -2147483648                                [OK]
74 limit_ptrdiff_max =3D 2147483647                                 [OK]
75 limit_size_max =3D 4294967295                                    [OK]
76 strtol_simple 35 =3D 35                                          [OK]
77 strtol_positive 35 =3D 35                                        [OK]
78 strtol_negative -35 =3D -35                                      [OK]
79 strtol_hex_auto 255 =3D 255                                      [OK]
80 strtol_base36 50507 =3D 50507                                    [OK]
81 strtol_cutoff 342391 =3D 342391                                  [OK]
82 strtol_octal_auto 9 =3D 9                                        [OK]
83 strtol_hex_00 0 =3D 0                                            [OK]
84 strtol_hex_FF 255 =3D 255                                        [OK]
85 strtol_hex_ff 255 =3D 255                                        [OK]
86 strtol_hex_prefix 255 =3D 255                                    [OK]
87 strtol_trailer 35 =3D 35                                         [OK]
88 strtol_overflow 2147483647 =3D 2147483647                        [OK]
89 strtol_underflow -2147483648 =3D -2147483648                     [OK]
90 strtoul_negative 4294967295 =3D 4294967295                       [OK]
91 strtoul_overflow 4294967295 =3D 4294967295                       [OK]
92 strerror_success =3D <errno=3D0>                                   [OK]
93 strerror_EINVAL =3D <errno=3D22>                                   [OK]
94 strerror_int_max =3D <errno=3D2147483647>                          [OK]
95 strerror_int_min =3D <errno=3D-2147483648>                         [OK]
96 tolower =3D 97                                                   [OK]
97 tolower_noop =3D 97                                              [OK]
98 toupper =3D 65                                                   [OK]
99 toupper_noop =3D 65                                              [OK]
100 abs =3D 10                                                      [OK]
101 abs_noop =3D 10                                                 [OK]
102 difftime =3D 0                                                  [OK]
Errors during this test: 0

Running test 'printf'
0 empty "" =3D ""                                                   [OK]
1 simple "foo" =3D "foo"                                            [OK]
2 string "foo" =3D "foo"                                            [OK]
3 number "1234" =3D "1234"                                          [OK]
4 negnumber "-1234" =3D "-1234"                                     [OK]
5 unsigned "12345" =3D "12345"                                      [OK]
6 char "c" =3D "c"                                                  [OK]
7 hex "f" =3D "f"                                                   [OK]
8 pointer "0x1" =3D "0x1"                                           [OK]
9 uintmax_t "18446744073709551615" =3D "18446744073709551615"       [OK]
10 intmax_t "-9223372036854775807" =3D "-9223372036854775807"       [OK]
11 truncation "01234567890123456789" =3D "01234567890123456789"     [OK]
12 string_width "         1" =3D "         1"                       [OK]
13 number_width "         1" =3D "         1"                       [OK]
14 width_trunc "                    " =3D "                    "    [OK]
15 scanf =3D 0                                                      [OK]
16 strerror =3D 0                                                   [OK]
Errors during this test: 0

Running test 'protection'
0 -fstackprotector                                                [OK]
Errors during this test: 0

Total number of errors: 0
Exiting with status 0
glaubitz@tirpitz:/srv/glaubitz/linux-nolibc/tools/testing/selftests/nolibc$

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

