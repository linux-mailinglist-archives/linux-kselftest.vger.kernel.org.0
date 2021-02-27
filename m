Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660CA326E90
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Feb 2021 19:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhB0SG7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Feb 2021 13:06:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:46827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhB0SFa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Feb 2021 13:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614448958;
        bh=BUrFkJRdMorIGyPHZ/sn3asqSQHApToumYQiv4PUyts=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c0FOR6fPgbSK7rkVNiSmZ1Z5GAnqKXApxUUhTg9gNC/PnTWd9gdZpxJT9NOIEzwji
         CtwIM7QG6S1SHUQrpfa8zBRDYzakki+jYq8ztI6PElYh3llNXkjJfCeegLLzHsjieh
         FnaE6SPuRD6akUDTTZmwG1k/gBrKTiZVgoL0Vb6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MK3Rm-1lW4u01oEg-00LZ4l; Sat, 27 Feb 2021 19:02:38 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
Date:   Sat, 27 Feb 2021 16:30:12 +0100
Message-Id: <20210227153013.6747-8-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227153013.6747-1-john.wood@gmx.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lgDBTFtAnDfrXI03PXITKePnX0sTM5BOZYhusvycVNJ9anmZQAq
 E6XNkOyHnOXbG/h0J1S0fdEDTnagZ455otTbtEb9+V84gaRrWdRcarSJ1TPpLHg47mXeVOm
 HU/OYKZdwKPVLAuSMpwAl7mlySnDq7/twkbgZeoA+MInl5IcifzHaws+RmBwGRIPbZROz81
 9EPxlJ24Wk22cFiYm/8kQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9QeVEX4n87I=:53y8CTzNX4HW2oPzSES8ZS
 WNsNyzo8B7ARXI9hxOjDyQeaeUOt29cWYp0jwrlkBlfu0klk/xRhz/uJ9DFr9dSD31uZLdcbO
 ZmNElXOHeZ08ux+MZoD5Z91OkMMUegMZL5RyDbAoWmyekmI0sCAdj+w/nBJ4ncyd3jHxE9x/y
 zrglSeXRImn63dU2DiQxbXkQKDszmxUnmL+xcUTohC0FPyO4Kug1HaOUI4Ix9gq9xFXFZh/G8
 +kJabTgHhtavMx0UqltdELBJ4TYL6cUSkka5hjjW15FIFDINqETLybfTMajbZxlFB5D/fCwMT
 JvPhkbrQCuURpNyrSLrUu+94A29Pcg1OL1+sW0PwWO9R507nOP4nA6Ln7vHaafNs0GO2bap5L
 fozEOR/9yQ+NIH1k9aNp9NEsC4JVbLXDJkqENwZ4B+aJxXud9DfXsay2i3Qnc52oB4VWMQBAX
 rwA3Dfg8kZ9OHKPJAigivD54HDKncujhpsEMwXXihANG8+t9iW/8sDEQrdZQd9OdY5zTQxnxa
 sT0/HSAzZFnhKT2dGI/zGSP/Wb0AeaK3Jk9n6Vu8em+073tW1nF+jBiHqDZqVw9yqzyZrRHwU
 ywWe6j+WIgOXQB6tGG5+IIGHRE/Eh+iCUskq1shc8TwkW8vy6Ve8yv4LOvG7IHy6VSZZHXYaw
 uWwklSXU/oxixowL4/GGrzzRfniui8qIfSMH7Y6zT14i1vJ/pF0ctFK29rqjPV6Q49xziQljL
 ak98beAkvqlyi9xlchTW1zeOCPuQ99mp+lNxmi7rxWC3jLUVh5VjIydYevWwjphReEOhlSKn+
 x+BNwS/su9TlPh2ArbEOy2s39T+au1pDa2J/zveArlhZC52b+KjrTyAFGuivJJG92pOuxs2Og
 DslPyd93rQmZ76lDA4Ig==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some info detailing what is the Brute LSM, its motivation, weak
points of existing implementations, proposed solutions, enabling,
disabling and self-tests.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 Documentation/admin-guide/LSM/Brute.rst | 224 ++++++++++++++++++++++++
 Documentation/admin-guide/LSM/index.rst |   1 +
 security/brute/Kconfig                  |   3 +-
 3 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/LSM/Brute.rst

diff --git a/Documentation/admin-guide/LSM/Brute.rst b/Documentation/admin=
-guide/LSM/Brute.rst
new file mode 100644
index 000000000000..485966a610bb
=2D-- /dev/null
+++ b/Documentation/admin-guide/LSM/Brute.rst
@@ -0,0 +1,224 @@
+.. SPDX-License-Identifier: GPL-2.0
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Brute: Fork brute force attack detection and mitigation LSM
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Attacks against vulnerable userspace applications with the purpose to bre=
ak ASLR
+or bypass canaries traditionally use some level of brute force with the h=
elp of
+the fork system call. This is possible since when creating a new process =
using
+fork its memory contents are the same as those of the parent process (the
+process that called the fork system call). So, the attacker can test the =
memory
+infinite times to find the correct memory values or the correct memory ad=
dresses
+without worrying about crashing the application.
+
+Based on the above scenario it would be nice to have this detected and
+mitigated, and this is the goal of this implementation. Specifically the
+following attacks are expected to be detected:
+
+1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
+    desirable memory layout is got (e.g. Stack Clash).
+2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly un=
til a
+    desirable memory layout is got (e.g. what CTFs do for simple network
+    service).
+3.- Launching processes without exec() (e.g. Android Zygote) and exposing=
 state
+    to attack a sibling.
+4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly unt=
il the
+    previously shared memory layout of all the other children is exposed =
(e.g.
+    kind of related to HeartBleed).
+
+In each case, a privilege boundary has been crossed:
+
+Case 1: setuid/setgid process
+Case 2: network to local
+Case 3: privilege changes
+Case 4: network to local
+
+So, what really needs to be detected are fork/exec brute force attacks th=
at
+cross any of the commented bounds.
+
+
+Other implementations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The public version of grsecurity, as a summary, is based on the idea of d=
elaying
+the fork system call if a child died due to some fatal signal (SIGSEGV, S=
IGBUS,
+SIGKILL or SIGILL). This has some issues:
+
+Bad practices
+-------------
+
+Adding delays to the kernel is, in general, a bad idea.
+
+Scenarios not detected (false negatives)
+----------------------------------------
+
+This protection acts only when the fork system call is called after a chi=
ld has
+crashed. So, it would still be possible for an attacker to fork a big amo=
unt of
+children (in the order of thousands), then probe all of them, and finally=
 wait
+the protection time before repeating the steps.
+
+Moreover, this method is based on the idea that the protection doesn't ac=
t if
+the parent crashes. So, it would still be possible for an attacker to for=
k a
+process and probe itself. Then, fork the child process and probe itself a=
gain.
+This way, these steps can be repeated infinite times without any mitigati=
on.
+
+Scenarios detected (false positives)
+------------------------------------
+
+Scenarios where an application rarely fails for reasons unrelated to a re=
al
+attack.
+
+
+This implementation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The main idea behind this implementation is to improve the existing ones
+focusing on the weak points annotated before. Basically, the adopted solu=
tion is
+to detect a fast crash rate instead of only one simple crash and to detec=
t both
+the crash of parent and child processes. Also, fine tune the detection fo=
cusing
+on privilege boundary crossing. And finally, as a mitigation method, kill=
 all
+the offending tasks involved in the attack instead of using delays.
+
+To achieve this goal, and going into more details, this implementation is=
 based
+on the use of some statistical data shared across all the processes that =
can
+have the same memory contents. Or in other words, a statistical data shar=
ed
+between all the fork hierarchy processes after an execve system call.
+
+The purpose of these statistics is, basically, collect all the necessary =
info
+to compute the application crash period in order to detect an attack. Thi=
s crash
+period is the time between the execve system call and the first fault or =
the
+time between two consecutive faults, but this has a drawback. If an appli=
cation
+crashes twice in a short period of time for some reason unrelated to a re=
al
+attack, a false positive will be triggered. To avoid this scenario the
+exponential moving average (EMA) is used. This way, the application crash=
 period
+will be a value that is not prone to change due to spurious data and foll=
ows the
+real crash period.
+
+To detect a brute force attack it is necessary that the statistics shared=
 by all
+the fork hierarchy processes be updated in every fatal crash and the most
+important data to update is the application crash period.
+
+There are two types of brute force attacks that need to be detected. The =
first
+one is an attack that happens through the fork system call and the second=
 one is
+an attack that happens through the execve system call. The first type use=
s the
+statistics shared by all the fork hierarchy processes, but the second typ=
e
+cannot use this statistical data due to these statistics dissapear when t=
he
+involved tasks finished. In this last scenario the attack info should be =
tracked
+by the statistics of a higher fork hierarchy (the hierarchy that contains=
 the
+process that forks before the execve system call).
+
+Moreover, these two attack types have two variants. A slow brute force at=
tack
+that is detected if a maximum number of faults per fork hierarchy is reac=
hed and
+a fast brute force attack that is detected if the application crash perio=
d falls
+below a certain threshold.
+
+Exponential moving average (EMA)
+--------------------------------
+
+This kind of average defines a weight (between 0 and 1) for the new value=
 to add
+and applies the remainder of the weight to the current average value. Thi=
s way,
+some spurious data will not excessively modify the average and only if th=
e new
+values are persistent, the moving average will tend towards them.
+
+Mathematically the application crash period's EMA can be expressed as fol=
lows:
+
+period_ema =3D period * weight + period_ema * (1 - weight)
+
+Related to the attack detection, the EMA must guarantee that not many cra=
shes
+are needed. To demonstrate this, the scenario where an application has be=
en
+running without any crashes for a month will be used.
+
+The period's EMA can be written now as:
+
+period_ema[i] =3D period[i] * weight + period_ema[i - 1] * (1 - weight)
+
+If the new crash periods have insignificant values related to the first c=
rash
+period (a month in this case), the formula can be rewritten as:
+
+period_ema[i] =3D period_ema[i - 1] * (1 - weight)
+
+And by extension:
+
+period_ema[i - 1] =3D period_ema[i - 2] * (1 - weight)
+period_ema[i - 2] =3D period_ema[i - 3] * (1 - weight)
+period_ema[i - 3] =3D period_ema[i - 4] * (1 - weight)
+
+So, if the substitution is made:
+
+period_ema[i] =3D period_ema[i - 1] * (1 - weight)
+period_ema[i] =3D period_ema[i - 2] * pow((1 - weight) , 2)
+period_ema[i] =3D period_ema[i - 3] * pow((1 - weight) , 3)
+period_ema[i] =3D period_ema[i - 4] * pow((1 - weight) , 4)
+
+And in a more generic form:
+
+period_ema[i] =3D period_ema[i - n] * pow((1 - weight) , n)
+
+Where n represents the number of iterations to obtain an EMA value. Or in=
 other
+words, the number of crashes to detect an attack.
+
+So, if we isolate the number of crashes:
+
+period_ema[i] / period_ema[i - n] =3D pow((1 - weight), n)
+log(period_ema[i] / period_ema[i - n]) =3D log(pow((1 - weight), n))
+log(period_ema[i] / period_ema[i - n]) =3D n * log(1 - weight)
+n =3D log(period_ema[i] / period_ema[i - n]) / log(1 - weight)
+
+Then, in the commented scenario (an application has been running without =
any
+crashes for a month), the approximate number of crashes to detect an atta=
ck
+(using the implementation values for the weight and the crash period thre=
shold)
+is:
+
+weight =3D 7 / 10
+crash_period_threshold =3D 30 seconds
+
+n =3D log(crash_period_threshold / seconds_per_month) / log(1 - weight)
+n =3D log(30 / (30 * 24 * 3600)) / log(1 - 0.7)
+n =3D 9.44
+
+So, with 10 crashes for this scenario an attack will be detected. If thes=
e steps
+are repeated for different scenarios and the results are collected:
+
+1 month without any crashes ----> 9.44 crashes to detect an attack
+1 year without any crashes -----> 11.50 crashes to detect an attack
+10 years without any crashes ---> 13.42 crashes to detect an attack
+
+However, this computation has a drawback. The first data added to the EMA=
 not
+obtains a real average showing a trend. So the solution is simple, the EM=
A needs
+a minimum number of data to be able to be interpreted. This way, the case=
 where
+a few first faults are fast enough followed by no crashes is avoided.
+
+Per system enabling/disabling
+-----------------------------
+
+This feature can be enabled at build time using the CONFIG_SECURITY_FORK_=
BRUTE
+option or using the visual config application under the following menu:
+
+Security options  --->  Fork brute force attack detection and mitigation
+
+Also, at boot time, this feature can be disable too, by changing the "lsm=
=3D" boot
+parameter.
+
+Kernel selftests
+----------------
+
+To validate all the expectations about this implementation, there is a se=
t of
+selftests. This tests cover fork/exec brute force attacks crossing the fo=
llowing
+privilege boundaries:
+
+1.- setuid process
+2.- privilege changes
+3.- network to local
+
+Also, there are some tests to check that fork/exec brute force attacks wi=
thout
+crossing any privilege boundariy already commented doesn't trigger the de=
tection
+and mitigation stage.
+
+To build the tests:
+make -C tools/testing/selftests/ TARGETS=3Dbrute
+
+To run the tests:
+make -C tools/testing/selftests TARGETS=3Dbrute run_tests
+
+To package the tests:
+make -C tools/testing/selftests TARGETS=3Dbrute gen_tar
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin=
-guide/LSM/index.rst
index a6ba95fbaa9f..1f68982bb330 100644
=2D-- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -41,6 +41,7 @@ subdirectories.
    :maxdepth: 1

    apparmor
+   Brute
    LoadPin
    SELinux
    Smack
diff --git a/security/brute/Kconfig b/security/brute/Kconfig
index 1bd2df1e2dec..334d7e88d27f 100644
=2D-- a/security/brute/Kconfig
+++ b/security/brute/Kconfig
@@ -7,6 +7,7 @@ config SECURITY_FORK_BRUTE
 	  vulnerable userspace processes. The detection method is based on
 	  the application crash period and as a mitigation procedure all the
 	  offending tasks are killed. Like capabilities, this security module
-	  stacks with other LSMs.
+	  stacks with other LSMs. Further information can be found in
+	  Documentation/admin-guide/LSM/Brute.rst.

 	  If you are unsure how to answer this question, answer N.
=2D-
2.25.1

