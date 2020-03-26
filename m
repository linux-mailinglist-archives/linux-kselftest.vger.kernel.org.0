Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4933F19377E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 06:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgCZFYw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 01:24:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18681 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgCZFYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 01:24:52 -0400
X-IronPort-AV: E=Sophos;i="5.72,307,1580745600"; 
   d="gz'50?scan'50,208,50";a="87332723"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Mar 2020 13:24:45 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 241BD49DF126;
        Thu, 26 Mar 2020 13:14:31 +0800 (CST)
Received: from localhost.localdomain (10.167.226.81) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 26 Mar 2020 13:24:43 +0800
From:   Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: runqslower build failed on Debian9
To:     Andrii Nakryiko <andriin@fb.com>
CC:     <linux-kselftest@vger.kernel.org>
Message-ID: <60b05d23-6352-b978-3bf7-5a86466bb297@cn.fujitsu.com>
Date:   Thu, 26 Mar 2020 13:26:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------394FEA4F02FC3E8FAF7F7BEE"
Content-Language: en-US
X-Originating-IP: [10.167.226.81]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 241BD49DF126.A15C9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--------------394FEA4F02FC3E8FAF7F7BEE
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Andrii.

I noticed you had added runqslower tool to tools/bpf, so drop this 
problem to you.


Now i failed to run bpf tests since i can't build runqslower.

Testing env: "Debian GNU/Linux 9 (stretch)"

kernel: 5.6.0-rc5

gcc: gcc 6.3

clang: clang-11.


Description: Build runqslower failed due to build error "incomplete 
type" and libbpf show unsupported BTF_KIND:7.

Whole build log please see the attatchment.


Error info

```

root@vm-snb-144 ~/linus/tools/bpf# make

Auto-detecting system features:
...                        libbfd: [ on  ]
...        disassembler-four-args: [ OFF ]

[snip]

   INSTALL  bpftool
   LINK     bpf_asm
   GEN      vmlinux.h
libbpf: unsupported BTF_KIND:7    (Many unsupported errors)
libbpf: unsupported BTF_KIND:7
libbpf: unsupported BTF_KIND:7

[snip]

(Many incomplete type errors)

.output/vmlinux.h:8401:18: error: field has incomplete type 'struct 
idt_bits'
         struct idt_bits bits;
                         ^
.output/vmlinux.h:8396:8: note: forward declaration of 'struct idt_bits'
struct idt_bits;
        ^
.output/vmlinux.h:8598:21: error: field has incomplete type 'struct 
trace_entry'
         struct trace_entry ent;
                            ^
.output/vmlinux.h:8595:8: note: forward declaration of 'struct trace_entry'
struct trace_entry;
        ^
.output/vmlinux.h:9006:25: error: array has incomplete element type 
'struct cyc2ns_data'
         struct cyc2ns_data data[2];
                                ^
.output/vmlinux.h:3669:8: note: forward declaration of 'struct cyc2ns_data'
struct cyc2ns_data;
        ^
fatal error: too many errors emitted, stopping now [-ferror-limit=]
20 errors generated.
Makefile:56: recipe for target '.output/runqslower.bpf.o' failed
make[1]: *** [.output/runqslower.bpf.o] Error 1
Makefile:119: recipe for target 'runqslower' failed
make: *** [runqslower] Error 2

```


-- 
Best Regards.
Liu Yiding




--------------394FEA4F02FC3E8FAF7F7BEE
Content-Type: application/gzip; name="build-log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="build-log.gz"

H4sICCU6fF4AA2J1aWxkLWxvZwDt2Ftv28gVwPF3fYoB+uA2qCXraouLBbqJ
nYURx1tsFmgBw0tQ5EhmTHKY4TC2+9DP3qEk60ZK0a3YIv0LiGLOjzxz5nA4
JKWVMn/7Gp9myeC02emIfzeiMMmzhlEqyhqDdPgnEXuPslb7KTfqNJBG+iZM
RiJ7yYyMxVB6Jtcyc2r1el2s+UThYDAMHHEnVCLE/eKuQZh5WSbjQST16VDl
+tTTo6zY9Zf37+2uNSFurm8/jPe1ybifQ+OOj4lXJRiMbNPb60+/3L42yee0
/uL5ft23cnn16d3V7eVYisEtNuk8+ZJF6klq2/rxw+X1r0WIuspNmps/augb
ogrxLxt4HtVm/e7dVGIvdVOph662udbVIj1HnpGBG+Sx3WGZGtrOg9VT35jX
pTEtRmND+IEZ7hn0GImVejfa82WkVpIsct+zh+qA/nC0Z7xyKnYMhxWhlEwi
zf71rMzFRrRHPx6WZyktX8WxSvaPtjYlf6RVnu5bzoqsRnLfNKtSib1w33Cl
RD5nKnGfdGhWa5Dq1Um7w+W+d35r09n+AinlbVef/detlWrN7iS2fWHDd8R1
IoZ5Yhd7u7qeTJrd1K53xg2TLDlxlndvtlpOq++IJ08ndk10hF3Vw1ESy8QU
a7zv6SATJ75KMnMivuReFA5DqcVQq1ikyka1G8Yu/dII85JKcXf6j+lhMjid
7Z/d2+RFmAxVffHG4aq0SDMTP4qq5h9qYtPn98WCzIqx18mmmraaBz4pyGhY
+aRQ/izf/jfuWjzvLD0p/Hx1OwP3QUZ2yXQDOczqD3ud+YVpM3tyyoxnQl8N
PmeNxZgLzcVzUTq5+83y2brL6dGNqgHMctg52pqkD4mzMModavN6SJUl9knJ
6LVceggqJeNKrRO1dqfM6GIPtb6L6c12eVD/C8XeVLZi4MXdxI3G1/x+a1xF
n984HdOS254HMjter5vO8nP2uNYevOyhdB9cjjt+hjpepqU5d3O5rkqnez9o
VPS7PI1n74nT69Fb7Ga6OB9xTixcIMea2P+VyVuenYsv1NN35Pm7yeIL9dFy
KE3XQ4JVzu8DL7T5BTGbuofX/HWuz+q9c8iqmbx1kMUp//7m6p9L5zeSz+Pf
S0onvoD9kp7PpuvbT7/9dHOzOMGWfsSZ/K4zeyL4GhfRn+2NfTJeR+RJlqep
0kYG4u1v790P17eXzjkMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAM
wzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAM
wzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAM
wzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAM
wzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAM
wzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAM
wzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAM
wzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzD8f8lC/Hx1
K8afhlbKNKIwybOGUSrKGvbAhs6TL1mknqRu1FVu0twUze6DjFKp3UAOs/qD
jfLxw+X1rztFyYxnQl8NPmeNIxz/7p3YcRQLx9s96urQIJNCj+P8oYNJIs8Y
ffh4BuZoRXGl1ok6PFpmdBFKHWF0iTT2gMcjlMkOL9Vq5NrDhkcY47RiNuRA
ZoeHe86OMMYHL3uIvfQoc8oN8ngS6eby4DKdhskk1PXth91CTa9Wzx789u/v
J3nMd6tPruTrRAzDSIow8aM8sAvnUKt4dTffaTu117Bf46Lv5/qD0zlrt51m
2xHjCevYQDIKhK1kEU3FaSSNFOYlleLETuvcNyKN85PatCRi3lb8+2HWvvD5
vaLX87ML58IRiTLSdqn0k6cDEUg/8rQtnUqEGi73N/971kdV3M5Zv/8djabZ
OXdanR1G82gnnVusq+EgN7I0sGUWxV+Vg/zGeNv91tbjXc2osnlzFVrtC6d1
scs5lXroTuK4D14SROVKlHcRk/++VY8NWXa3nwQVCa6lzcU57zadVnOH4gRy
kI/czChdrsqCiSBzB57/uLEelRn1m1vXYSmXctvGkffane73c6n3Ou0Ok3xd
cbrNs+/oVHftParV22E08qtMjOurxG57YWJKQ1vdwb5FzTdk8O3TXbnK9y7a
WxegnOIa2FyaXvP8OzrRvfMLbt+9fq+928rmR8p/dCcTJ5BfQ79cifIudqKZ
fZe1Xr/T27oiVdmtpY2VOW817fzozyrjae29rFZGRjK28Vbv4ZnvTv52XbdV
cR9f8vH2Xft+m/pUz5hut7PDTX0luer2b5Sma99KtnqsSUf2HdS45kT82Xv0
5hfquPnkL7Mhv+4niv8qKlGVRtOena1XhkmHtaXNzYNs93pOu7XH+Y/zyL5g
elHkWtIvpfO/4qL4DmV2125tNwfWJdy82P72X8qxun1jhS7a5y3H3hJ2uB8Y
V8tRVr4nTNpF8bW2BFUpdC+2f5yddb68vXmInbOm09xleQwD4w5CUx7jK4ji
a/15ri50f/sVcJ7ASsPmgXb7F7u9qdgHBl+umeELVszund9SbDbbT+WlRMpt
G4fdPzvrOa3uHhe5/+K3kswNPOOV739zE8XX3RYXdvUzXm/7FW4poXLbQhmG
djN6HbFRSsRe8jLZzoSMQ2MfSv9qx6LSNExGtvcncXc6HPtpFFr/8b7WOns9
YCQTabORQb320XuUxU9dTtc+P2vph7ZeNmthPD2SRpy8jnD1J7ITMfTsYUEt
tgHumveOePPmjbhbt/u9uCq6Fs15h81mv7LH+aFLfUw7mOtryFbtP6DKT5oP
9QEA

--------------394FEA4F02FC3E8FAF7F7BEE--
