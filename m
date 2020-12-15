Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41372DADB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 14:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgLONGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 08:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgLONGl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 08:06:41 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5BC06179C
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 05:06:01 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id u7so10908821vsg.11
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6JcWbpI6jGa01OPHXVMD2J1Jt7vqUJ1vGYJXmb3BYg=;
        b=GySPu3JPn5oY5z7HEHsmBkWTtINCkr42KRf5OqSuvPZXiIDp/6j7IIku1ErEVbzbla
         TO5zYrJ5XkzpcCLkXeCcTcbXnTxbbUur4fxOhLOIvmsA0qPIy3/RrNvvHREkfCMaRgtI
         XCgva/BiX2NszgfeuU/PudEkoE5XxRM2hnmkdGwsWBaFDPKuNnjCggRyl3WPnjL7MSCY
         +3x/R1vUsVoavfWw8teVdheWGKGsNZcw0FO0fxpNKKi8TCaGePbm/Wtc7FrrcXk9HYFN
         R+SmturpAPzB8742ZBC8IbFa4yieJ94bSrF59pQ9Uh94V0k5behe+HT2G0XgFdo7suIh
         qSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6JcWbpI6jGa01OPHXVMD2J1Jt7vqUJ1vGYJXmb3BYg=;
        b=kjy86PrBW3sQRo/zzMVZCXIEVnFhVlDAO+2WsdtxxZeaTSmdWFLhYuYkTgtXHi1y5J
         1b089tcr8QakRyQ9dQbRj9IVReeUIxzvdB2NpQoMZLdJ5YAfN/GfDd3eyUnqAr7rMRz6
         suh/iuKIVLaqzj/aAR1RM8IogM+oZXVFpxCjoI2RTK25t7SNzutMPyXmFMUB4SLIfd7n
         V1aEjMrCcnqU1gLUv8L5UeEkqNd6DF3cJ6ZJnMi0i3ru5h1BYDIosNd4XlF/INte4xFj
         O31nBAGHR1lmjFkGC2Qix54ab4gBRw8Mr23rZT44IYIHXw0dUbj4NKqS+39Axp3VWJ0T
         49EQ==
X-Gm-Message-State: AOAM533P3qMp7mZRgDkdrnOWvGD5/0KMLUk9U2HCGiw810vl2KIS6XzN
        JA4qQ9hb6hQNI11WKNWfdc1zSjjPgTzgJ5BdTl4dc0vGnQmQNg==
X-Google-Smtp-Source: ABdhPJzd2zd1mfj+2JOvG7Kb2IKM7m6kQfLvrUUQH1zRlLxKdNB34zX+2yZ2pPZSMkGbOyZpb8F0jrq3/7pDR8A/s0U=
X-Received: by 2002:a05:6102:18c:: with SMTP id r12mr28967382vsq.34.1608037560466;
 Tue, 15 Dec 2020 05:06:00 -0800 (PST)
MIME-Version: 1.0
References: <e479c654b6ca08057bf18a4e1c1d1ed3cdf8fdc8.camel@rajagiritech.edu.in>
In-Reply-To: <e479c654b6ca08057bf18a4e1c1d1ed3cdf8fdc8.camel@rajagiritech.edu.in>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Tue, 15 Dec 2020 18:35:24 +0530
Message-ID: <CAG=yYwmN9vw4RqQ1pmF9oFx9BtS=npOBakMr1GO2WaHF7t1wrg@mail.gmail.com>
Subject: [WARNING ]Re: related to fixing depreciated api
To:     Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000942ce605b6806b4a"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000942ce605b6806b4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2020 at 10:12 PM Jeffrin Jose T
<jeffrin@rajagiritech.edu.in> wrote:
>
> hello,
>
> i have worked on to  fix  depreciated api issue from
> tools/testing/selftests/intel_pstate/aerf.c
>
> i met with the following error related...
>
> --------------x------------------x----------------->
> $pwd
> /home/jeffrin/UP/linux-kselftest/tools/testing/selftests/intel_pstate
> $make
> gcc  -Wall -D_GNU_SOURCE    aperf.c /home/jeffrin/UP/linux-
> kselftest/tools/testing/selftests/kselftest_harness.h
> /home/jeffrin/UP/linux-kselftest/tools/testing/selftests/kselftest.h -
> lm -o /home/jeffrin/UP/linux-
> kselftest/tools/testing/selftests/intel_pstate/aperf
> aperf.c: In function =E2=80=98main=E2=80=99:
> aperf.c:58:2: warning: =E2=80=98ftime=E2=80=99 is deprecated [-Wdeprecate=
d-
> declarations]
>    58 |  ftime(&before);
>       |  ^~~~~
> In file included from aperf.c:9:
> /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
>    39 | extern int ftime (struct timeb *__timebuf)
>       |            ^~~~~
> aperf.c:67:2: warning: =E2=80=98ftime=E2=80=99 is deprecated [-Wdeprecate=
d-
> declarations]
>    67 |  ftime(&after);
>       |  ^~~~~
> In file included from aperf.c:9:
> /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
>    39 | extern int ftime (struct timeb *__timebuf)
>       |            ^~~~~
> $
> ----------------x---------------x---------------------->
>
>
> from ftime manual  i found that it is depreciated...
>
> This  function is deprecated, and will be removed in a future version
> of the GNU C library.  Use clock_gettime(2) instead.
>
>
> now clock_gettime  gives  new data structure.
>
>  struct timespec {
>                time_t   tv_sec;        /* seconds */
>                long     tv_nsec;       /* nanoseconds */
>            };
>
>
> i worked on with the new data structure and some errors that came
> along.
> typical final output looks good but  values of runtime and typical
> frequency
> does not look normal during "sudo bash run.sh".
>
> output of "git diff" and  a  portion of output of   "sudo bash run.sh".
> is attached.
>
>
>
> --
> software engineer
> rajagiri school of engineering and technology - autonomous
>
>


--=20
software engineer
rajagiri school of engineering and technology

--000000000000942ce605b6806b4a
Content-Type: text/plain; charset="US-ASCII"; name="diff-or.txt"
Content-Disposition: attachment; filename="diff-or.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kipzzvmd0>
X-Attachment-Id: f_kipzzvmd0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ludGVsX3BzdGF0ZS9hcGVyZi5j
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaW50ZWxfcHN0YXRlL2FwZXJmLmMKaW5kZXggZjZj
ZDAzYTg3NDkzLi43ZTM1ZTc4NzJmMTYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2ludGVsX3BzdGF0ZS9hcGVyZi5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2lu
dGVsX3BzdGF0ZS9hcGVyZi5jCkBAIC02LDcgKzYsNyBAQAogI2luY2x1ZGUgPHN5cy90eXBlcy5o
PgogI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4KLSNpbmNsdWRlIDxz
eXMvdGltZWIuaD4KKyNpbmNsdWRlIDx0aW1lLmg+CiAjaW5jbHVkZSA8c2NoZWQuaD4KICNpbmNs
dWRlIDxlcnJuby5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgpAQCAtMjIsMTAgKzIyLDEyIEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikgewogCWxvbmcgbG9uZyB0c2MsIG9sZF90c2Ms
IG5ld190c2M7CiAJbG9uZyBsb25nIGFwZXJmLCBvbGRfYXBlcmYsIG5ld19hcGVyZjsKIAlsb25n
IGxvbmcgbXBlcmYsIG9sZF9tcGVyZiwgbmV3X21wZXJmOwotCXN0cnVjdCB0aW1lYiBiZWZvcmUs
IGFmdGVyOworCXN0cnVjdCB0aW1lc3BlYyBiZWZvcmUsIGFmdGVyOworICAgICAgICBjbG9ja2lk
X3QgY2xraWQ7CiAJbG9uZyBsb25nIGludCBzdGFydCwgZmluaXNoLCB0b3RhbDsKIAljcHVfc2V0
X3QgY3B1c2V0OwogCisKIAlpZiAoYXJnYyAhPSAyKSB7CiAJCXVzYWdlKGFyZ3ZbMF0pOwogCQly
ZXR1cm4gMTsKQEAgLTQxLDYgKzQzLDEwIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikgewogCiAJc3ByaW50Zihtc3JfZmlsZV9uYW1lLCAiL2Rldi9jcHUvJWQvbXNyIiwgY3B1KTsK
IAlmZCA9IG9wZW4obXNyX2ZpbGVfbmFtZSwgT19SRE9OTFkpOworICAgICAgICAjZGVmaW5lIENM
T0NLRkQgMworICAgICAgICAjZGVmaW5lIEZEX1RPX0NMT0NLSUQoZmQpICAgKCh+KGNsb2NraWRf
dCkgKGZkKSA8PCAzKSB8IENMT0NLRkQpCisgICAgICAgIGNsa2lkID0gRkRfVE9fQ0xPQ0tJRChm
ZCk7CisKIAogCWlmIChmZCA9PSAtMSkgewogCQlwcmludGYoIi9kZXYvY3B1LyVkL21zcjogJXNc
biIsIGNwdSwgc3RyZXJyb3IoZXJybm8pKTsKQEAgLTU1LDcgKzYxLDcgQEAgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKiphcmd2KSB7CiAJCXJldHVybiAxOwogCX0KIAotCWZ0aW1lKCZiZWZvcmUp
OworCWNsb2NrX2dldHRpbWUoY2xraWQsJmJlZm9yZSk7CiAJcHJlYWQoZmQsICZvbGRfdHNjLCAg
c2l6ZW9mKG9sZF90c2MpLCAweDEwKTsKIAlwcmVhZChmZCwgJm9sZF9hcGVyZiwgIHNpemVvZihv
bGRfbXBlcmYpLCAweGU3KTsKIAlwcmVhZChmZCwgJm9sZF9tcGVyZiwgIHNpemVvZihvbGRfYXBl
cmYpLCAweGU4KTsKQEAgLTY0LDcgKzcwLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiph
cmd2KSB7CiAJCXNxcnQoaSk7CiAJfQogCi0JZnRpbWUoJmFmdGVyKTsKKwljbG9ja19nZXR0aW1l
KGNsa2lkLCZhZnRlcik7CiAJcHJlYWQoZmQsICZuZXdfdHNjLCAgc2l6ZW9mKG5ld190c2MpLCAw
eDEwKTsKIAlwcmVhZChmZCwgJm5ld19hcGVyZiwgIHNpemVvZihuZXdfbXBlcmYpLCAweGU3KTsK
IAlwcmVhZChmZCwgJm5ld19tcGVyZiwgIHNpemVvZihuZXdfYXBlcmYpLCAweGU4KTsKQEAgLTcz
LDExICs3OSwxMCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpIHsKIAlhcGVyZiA9
IG5ld19hcGVyZi1vbGRfYXBlcmY7CiAJbXBlcmYgPSBuZXdfbXBlcmYtb2xkX21wZXJmOwogCi0J
c3RhcnQgPSBiZWZvcmUudGltZSoxMDAwICsgYmVmb3JlLm1pbGxpdG07Ci0JZmluaXNoID0gYWZ0
ZXIudGltZSoxMDAwICsgYWZ0ZXIubWlsbGl0bTsKLQl0b3RhbCA9IGZpbmlzaCAtIHN0YXJ0Owot
Ci0JcHJpbnRmKCJydW5UaW1lOiAlNC4yZlxuIiwgMS4wKnRvdGFsLzEwMDApOwotCXByaW50Zigi
ZnJlcTogJTcuMGZcbiIsIHRzYyAvICgxLjAqYXBlcmYgLyAoMS4wICogbXBlcmYpKSAvIHRvdGFs
KTsKKwlzdGFydCA9IGJlZm9yZS50dl9zZWMqMTAwMDAwMCArIGJlZm9yZS50dl9uc2VjOworCWZp
bmlzaCA9IGFmdGVyLnR2X3NlYyoxMDAwMDAwICsgYWZ0ZXIudHZfbnNlYzsKKwl0b3RhbCA9IGZp
bmlzaCAtIHN0YXJ0OyAKKwlwcmludGYoInJ1blRpbWU6ICU0LjJmXG4iLCAxLjAqdG90YWwvMTAw
MDAwMCk7IAorCXByaW50ZigiZnJlcTogJTcuMGZcbiIsIHRzYyAvICgxLjAgKiBhcGVyZiAvMS4w
ICogKG1wZXJmKSkgLyB0b3RhbCk7CiAJcmV0dXJuIDA7CiB9Cg==
--000000000000942ce605b6806b4a
Content-Type: text/plain; charset="US-ASCII"; name="shot.txt"
Content-Disposition: attachment; filename="shot.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kiq00i4n1>
X-Attachment-Id: f_kiq00i4n1

U2V0dGluZyBtYXhpbXVtIGZyZXF1ZW5jeSB0byA1MDAKbGF1bmNoaW5nIGFwZXJmIGxvYWQgb24g
MApsYXVuY2hpbmcgYXBlcmYgbG9hZCBvbiAxCmxhdW5jaGluZyBhcGVyZiBsb2FkIG9uIDIKbGF1
bmNoaW5nIGFwZXJmIGxvYWQgb24gMwpzbGVlcGluZyBmb3IgNSBzZWNvbmRzCndhaXRpbmcgZm9y
IGpvYiBpZCA3NTIxCnJ1blRpbWU6IDAuMDAKZnJlcTogICAgIGluZgpydW5UaW1lOiAwLjAwCmZy
ZXE6ICAgICBpbmYKcnVuVGltZTogMC4wMApmcmVxOiAgICAgaW5mCnJ1blRpbWU6IDAuMDAKZnJl
cTogICAgIGluZgp3YWl0aW5nIGZvciBqb2IgaWQgNzUyMgp3YWl0aW5nIGZvciBqb2IgaWQgNzUy
Mwp3YWl0aW5nIGZvciBqb2IgaWQgNzUyNApTZXR0aW5nIG1heGltdW0gZnJlcXVlbmN5IHRvIDQw
MApsYXVuY2hpbmcgYXBlcmYgbG9hZCBvbiAwCmxhdW5jaGluZyBhcGVyZiBsb2FkIG9uIDEKbGF1
bmNoaW5nIGFwZXJmIGxvYWQgb24gMgpsYXVuY2hpbmcgYXBlcmYgbG9hZCBvbiAzCnNsZWVwaW5n
IGZvciA1IHNlY29uZHMKd2FpdGluZyBmb3Igam9iIGlkIDc1NDAKcnVuVGltZTogMC4wMApmcmVx
OiAgICAgaW5mCnJ1blRpbWU6IDAuMDAKZnJlcTogICAgIGluZgpydW5UaW1lOiAwLjAwCmZyZXE6
ICAgICBpbmYKd2FpdGluZyBmb3Igam9iIGlkIDc1NDEKcnVuVGltZTogMC4wMApmcmVxOiAgICAg
aW5mCndhaXRpbmcgZm9yIGpvYiBpZCA3NTQyCndhaXRpbmcgZm9yIGpvYiBpZCA3NTQzCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQpUaGUgbWFya2V0aW5nIGZyZXF1ZW5jeSBvZiB0aGUgY3B1IGlzIDIzMDAgTUh6
ClRoZSBtYXhpbXVtIGZyZXF1ZW5jeSBvZiB0aGUgY3B1IGlzIDIzMDAgTUh6ClRoZSBtaW5pbXVt
IGZyZXF1ZW5jeSBvZiB0aGUgY3B1IGlzIDQwMCBNSHoKVGFyZ2V0CSAgICAgIEFjdHVhbAkgICAg
RGlmZmVyZW5jZQkgIE1TUigweDE5OSkJbWF4X3BlcmZfcGN0CjIzMDAJICAgICAgMjMwMAkgICAg
MAkJICAweDQwMAkJMjMwMDAwCjIyMDAJICAgICAgMjIwMAkgICAgMAkJICAweDQwMAkJMjMwMDAw
CjIxMDAJICAgICAgMjEwMAkgICAgMAkJICAweDQwMAkJMjMwMDAwCjIwMDAJICAgICAgMjAwMAkg
ICAgMAkJICAweDQwMAkJMjMwMDAwCjE5MDAJICAgICAgMTkwMAkgICAgMAkJICAweDQwMAkJMjMw
MDAwCjE4MDAJICAgICAgMTgwMAkgICAgMAkJICAweDQwMAkJMjMwMDAwCjE3MDAJICAgICAgMTcw
MAkgICAgMAkJICAweDQwMAkJMjMwMDAwCjE2MDAJICAgICAgMTYwMAkgICAgMAkJICAweDQwMAkJ
MjMwMDAwCjE1MDAJICAgICAgMTUwMAkgICAgMAkJICAweDQwMAkJMjMwMDAwCjE0MDAJICAgICAg
MTQwMAkgICAgMAkJICAweDQwMAkJMjMwMDAwCjEzMDAJICAgICAgMTMwMAkgICAgMAkJICAweDQw
MAkJMjMwMDAwCjEyMDAJICAgICAgMTIwMAkgICAgMAkJICAweDQwMAkJMjMwMDAwCjExMDAJICAg
ICAgMTEwMAkgICAgMAkJICAweDQwMAkJMjMwMDAwCjEwMDAJICAgICAgOTk5CSAgICAtMQkJICAw
eDQwMAkJMjMwMDAwCjkwMAkgICAgICA5MDAJICAgIDAJCSAgMHg0MDAJCTIzMDAwMAo4MDAJICAg
ICAgODAwCSAgICAwCQkgIDB4NDAwCQkyMzAwMDAKNzAwCSAgICAgIDcwMAkgICAgMAkJICAweDQw
MAkJMjMwMDAwCjYwMAkgICAgICA2MDAJICAgIDAJCSAgMHg0MDAJCTIzMDAwMAo1MDAJICAgICAg
NTAwCSAgICAwCQkgIDB4NDAwCQkyMzAwMDAKNDAwCSAgICAgIDQwMAkgICAgMAkJICAw
--000000000000942ce605b6806b4a--
