Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AD72D9CD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Dec 2020 17:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406513AbgLNQnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Dec 2020 11:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgLNQnD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Dec 2020 11:43:03 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5816C061793
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Dec 2020 08:42:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t22so2992781pfl.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Dec 2020 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version;
        bh=JezVwkcUvzbDeHvXSRBpUCVs/qIVAUJGi+DKg0XJKa8=;
        b=mXy18jyh6x9Yg5x/9PYmMAfeBUgoUAzxkI+cBR3uyWjLrqttklGNM7KuVM/9iipOZe
         VHQ9K2I6ui+Nj3uEYv48Btuq1yNGWExK39A4eceIf3RWrY/2FfHE34g5jtEc8X1z8u2r
         FCxIyX3B7DGQVYCT+4BP9UO9+umtNa23eqJHtlW/q0zeoOKQ/0DxmMIvZ2fdRB8cWKAo
         zQRJpywYzWIU73CiY+vAFhXTp0eLd9toXWU0aoQMAVANbcruQRWN692WWd5ZsRlqIU5b
         r15VUxXEoJG0qsMjChSfzd0P5vjMRjzn+8aS5kXhxmo4ig7DhvGcszGEmfLFcFA9d9zv
         eZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version;
        bh=JezVwkcUvzbDeHvXSRBpUCVs/qIVAUJGi+DKg0XJKa8=;
        b=a4Fw4Zs2HTegDDCU0o1+0qiJR9O7yOlMob+JcI2XrUdYX2O3hvKiTusQnc4OgQSqKu
         afJ94dLJwc/lqnU+DbJOMV6iQ1wWZeCXP10YMSnTYWpRTkTzGr6MP3UiIEjz025C6TU1
         isDGSgFX8HAbffhNVT+WQGAaqwFPlfPKXWzoW60Wq9pnDSSatfnQB1UoXl9stzipKw+3
         fOf9Xjzbq0Cfqjgo1YO7rcSANslEmrQ4/QOGrqqhhPSyeot0rblKhD2xjL6X4HfoZefs
         IyOikq9V0QFmmVtWIctS9AL4031zg/wcnPFsqqd9cwNGwIl3kc1/Zv3sRsX3Ro0YPLd7
         lV7g==
X-Gm-Message-State: AOAM533nLa4l9cIMlAaAREQQ5fT1TfVoPI2ZIunzfan4EkMNdtXEC8Te
        J8uXyhTpCGvt2w2ol/8Cn6RcgbJykt3oeg==
X-Google-Smtp-Source: ABdhPJzM/uVhPAKhk3NynN9yUtwSZCsn+2/4gY8gnVryTIoG815YrBdV7grCk4Reut9MNSIKbdcOIg==
X-Received: by 2002:a62:3582:0:b029:19e:4935:bea2 with SMTP id c124-20020a6235820000b029019e4935bea2mr24381264pfa.34.1607964143127;
        Mon, 14 Dec 2020 08:42:23 -0800 (PST)
Received: from [192.168.1.9] ([171.61.231.84])
        by smtp.gmail.com with ESMTPSA id u12sm19496373pfn.88.2020.12.14.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:42:22 -0800 (PST)
Message-ID: <e479c654b6ca08057bf18a4e1c1d1ed3cdf8fdc8.camel@rajagiritech.edu.in>
Subject: related to fixing  depreciated  api
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Dec 2020 22:12:14 +0530
Content-Type: multipart/mixed; boundary="=-b+EomzCa5T42UxINaR95"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--=-b+EomzCa5T42UxINaR95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

hello,

i have worked on to  fix  depreciated api issue from
tools/testing/selftests/intel_pstate/aerf.c

i met with the following error related...

--------------x------------------x----------------->
$pwd
/home/jeffrin/UP/linux-kselftest/tools/testing/selftests/intel_pstate
$make
gcc  -Wall -D_GNU_SOURCE    aperf.c /home/jeffrin/UP/linux-
kselftest/tools/testing/selftests/kselftest_harness.h
/home/jeffrin/UP/linux-kselftest/tools/testing/selftests/kselftest.h -
lm -o /home/jeffrin/UP/linux-
kselftest/tools/testing/selftests/intel_pstate/aperf
aperf.c: In function ‘main’:
aperf.c:58:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
declarations]
   58 |  ftime(&before);
      |  ^~~~~
In file included from aperf.c:9:
/usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
   39 | extern int ftime (struct timeb *__timebuf)
      |            ^~~~~
aperf.c:67:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
declarations]
   67 |  ftime(&after);
      |  ^~~~~
In file included from aperf.c:9:
/usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
   39 | extern int ftime (struct timeb *__timebuf)
      |            ^~~~~
$
----------------x---------------x---------------------->


from ftime manual  i found that it is depreciated...

This  function is deprecated, and will be removed in a future version
of the GNU C library.  Use clock_gettime(2) instead.


now clock_gettime  gives  new data structure.

 struct timespec {
               time_t   tv_sec;        /* seconds */
               long     tv_nsec;       /* nanoseconds */
           };


i worked on with the new data structure and some errors that came
along.
typical final output looks good but  values of runtime and typical
frequency
does not look normal during "sudo bash run.sh".

output of "git diff" and  a  portion of output of   "sudo bash run.sh".
is attached.



-- 
software engineer
rajagiri school of engineering and technology - autonomous



--=-b+EomzCa5T42UxINaR95
Content-Disposition: attachment; filename="diff-or.txt"
Content-Type: text/plain; name="diff-or.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

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


--=-b+EomzCa5T42UxINaR95
Content-Disposition: attachment; filename="shot.txt"
Content-Type: text/plain; name="shot.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

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


--=-b+EomzCa5T42UxINaR95--

