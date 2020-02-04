Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9215218E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 21:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBDUhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Feb 2020 15:37:11 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46032 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBDUhL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Feb 2020 15:37:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so19859765oic.12
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2020 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IyvgOStPbIhT6yjCRAzBxT2FlMGgx/EgK7HsJDgeo4=;
        b=QLz9JJhBPuHe6f0G61EgXxR/Rh7pt49RfVDHpihIpKgM2B64PSACBcxasl7axt4l8D
         jSQmdsyxNVg5mDU6HR1QncKJMFnSKUsY/7zxfCR4W+vpCXgYAJ+DXJ1e7gt6nDd7jcDd
         KAqv+StTGFTTQxFsipvCth8LX5JnSU3pXISVp5EUx6vUR/AwJ340q+LvLGPY+dMPS8z0
         8G9gEmrVXvqHnkNkkyg6UlIv3v5lZAOHfFGB4/QSJ/3pVmrcnAd86xsDbW7BPxbC6uLS
         /WT430SySM05tGhc2+8I477Dw+WYArLRKXCOP6NdlISDeNyNVozCvNQ45MbDH5yGYAs9
         k92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IyvgOStPbIhT6yjCRAzBxT2FlMGgx/EgK7HsJDgeo4=;
        b=nvhNvNJqo9s0UxdPR6BlhazZXOxDJHdp+xQ6GoRZdo/9W6ufiLtk/xHP3m//y7n4fC
         Fyl/Rq/quLSHD5QzejluycBZYtEXTyi4gpIvPz6MtzsEbgB+rW8/kW6j5KFd9I0ZKtRx
         CMGHQLbx8d/9xbgtBhQdfU8AwAgjdpnGchfsbymjx8m7f4njJjOSEU+Xjycaabo4PqL6
         nfZzQSXaa/hb2/p+brQRscwE39l9AfSxiTGD3jAklZrvqMPdrqOvi/oRHUmeVcYu3wYX
         Yc2CqFmT5U3/+lOHDXFXbwnLl73fbyWCA2rCzTwRs55bZj+DgnSND++1TT56UbOrriOK
         F59g==
X-Gm-Message-State: APjAAAWv9FhU0OGxMTzuIFHGQ6mRwWupbmGC6V/yiYbnhZJ2F/ZKETa0
        xAX4vd8zVSeydrC7YN3rqjfBcLYY850y7SM1wWjz7A==
X-Google-Smtp-Source: APXvYqyJPGQtUbcLKV30ftv+EHVGej6UEganAn2adi3OT3fx2VIaYznLhDPHHtkdJUNX5jcWHkJNRy7I9Nr/3VkZ1d0=
X-Received: by 2002:a05:6808:7dd:: with SMTP id f29mr572486oij.67.1580848629368;
 Tue, 04 Feb 2020 12:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-8-almasrymina@google.com> <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
In-Reply-To: <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 4 Feb 2020 12:36:57 -0800
Message-ID: <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000003c7ea059dc601fb"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000003c7ea059dc601fb
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 4, 2020 at 8:26 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
>
> There are still a couple of places where 2MB page size is being used.
> These are my workarounds to get the tests running on ppc64.
>

Thanks for the changes!

> Also I had missed running charge_reserved_hugetlb.sh the last time.
> Right now, it stops at the following scenario.
>
> Test normal case with write.
> private=, populate=, method=2, reserve=
> nr hugepages = 10
> writing cgroup limit: 83886080
> writing reseravation limit: 83886080
>
> Starting:
> hugetlb_usage=0
> reserved_usage=0
> expect_failure is 0
> Putting task in cgroup 'hugetlb_cgroup_test'
> Method is 2
> Executing ./write_to_hugetlbfs -p /mnt/huge/test -s 83886080 -w  -m 2  -l
> Writing to this path: /mnt/huge/test
> Writing this size: 83886080
> Not populating.
> Using method=2
> Shared mapping.
> RESERVE mapping.
> Allocating using SHM.
> shmid: 0x5, shmget key:0
> shmaddr: 0x7dfffb000000
> Writing to memory.
> Starting the writes:
> .write_result is 0
> .After write:
> hugetlb_usage=16777216
> reserved_usage=83886080
> ....kiling write_to_hugetlbfs
> ...Received 2.
> Deleting the memory
> Done deleting the memory
> 16777216
> 83886080
> Memory charged to hugtlb=16777216
> Memory charged to reservation=83886080
> expected (83886080) != actual (16777216): Reserved memory charged to hugetlb cgroup.
> CLEANUP DONE
>
>

So the problem in this log seems to be that this log line is missing:
    echo Waiting for hugetlb memory to reach size $size.

The way the test works is that it starts a process that writes the
hugetlb memory, then it *should* wait until the memory is written,
then it should record the cgroup accounting and kill the process. It
seems from your log that the wait doesn't happen, so the test
continues before the background process has had time to write the
memory properly. Essentially wait_for_hugetlb_memory_to_get_written()
never gets called in your log.

Can you try this additional attached diff on top of your changes? I
attached the diff and pasted the same here, hopefully one works for
you:

diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index efd68093ce3e9..18d33684faade 100755
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -169,19 +169,36 @@ function write_hugetlbfs_and_get_usage() {
   echo reserved_usage="$reserved_before"
   echo expect_failure is "$expect_failure"

+  output=$(mktemp)
   set +e
   if [[ "$method" == "1" ]] || [[ "$method" == 2 ]] ||
     [[ "$private" == "-r" ]] && [[ "$expect_failure" != 1 ]]; then

     bash write_hugetlb_memory.sh "$size" "$populate" "$write" \
-      "$cgroup" "$path" "$method" "$private" "-l" "$reserve" &
+      "$cgroup" "$path" "$method" "$private" "-l" "$reserve" 2>&1 |
tee $output &

     local write_result=$?
+    local write_pid=$!

-    if [[ "$reserve" != "-n" ]]; then
-      wait_for_hugetlb_memory_to_get_reserved "$cgroup" "$size"
-    elif [[ "$populate" == "-o" ]] || [[ "$write" == "-w" ]]; then
+    until grep -q -i "DONE" $output; do
+      echo waiting for DONE signal.
+      if ! ps $write_pid > /dev/null
+      then
+        echo "FAIL: The write died"
+        cleanup
+        exit 1
+      fi
+      sleep 0.5
+    done
+
+    echo ================= write_hugetlb_memory.sh output is:
+    cat $output
+    echo ================= end output.
+
+    if [[ "$populate" == "-o" ]] || [[ "$write" == "-w" ]]; then
       wait_for_hugetlb_memory_to_get_written "$cgroup" "$size"
+    elif [[ "$reserve" != "-n" ]]; then
+      wait_for_hugetlb_memory_to_get_reserved "$cgroup" "$size"
     else
       # This case doesn't produce visible effects, but we still have
       # to wait for the async process to start and execute...
@@ -227,7 +244,7 @@ function cleanup_hugetlb_memory() {
   set +e
   local cgroup="$1"
   if [[ "$(pgrep -f write_to_hugetlbfs)" != "" ]]; then
-    echo kiling write_to_hugetlbfs
+    echo killing write_to_hugetlbfs
     killall -2 write_to_hugetlbfs
     wait_for_hugetlb_memory_to_get_depleted $cgroup
   fi
diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c
b/tools/testing/selftests/vm/write_to_hugetlbfs.c
index 85811c3384a10..7f75ad5f7b580 100644
--- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
@@ -207,13 +207,13 @@ int main(int argc, char **argv)
  }
  printf("shmid: 0x%x, shmget key:%d\n", shmid, key);

- shmaddr = shmat(shmid, NULL, 0);
- if (shmaddr == (char *)-1) {
+ ptr = shmat(shmid, NULL, 0);
+ if (ptr == (int *)-1) {
  perror("Shared memory attach failure");
  shmctl(shmid, IPC_RMID, NULL);
  exit(2);
  }
- printf("shmaddr: %p\n", shmaddr);
+ printf("shmaddr: %p\n", ptr);

  break;
  default:
@@ -223,25 +223,7 @@ int main(int argc, char **argv)

  if (write) {
  printf("Writing to memory.\n");
- if (method != SHM) {
- memset(ptr, 1, size);
- } else {
- printf("Starting the writes:\n");
- for (i = 0; i < size; i++) {
- shmaddr[i] = (char)(i);
- if (!(i % (1024 * 1024)))
- printf(".");
- }
- printf("\n");
-
- printf("Starting the Check...");
- for (i = 0; i < size; i++)
- if (shmaddr[i] != (char)i) {
- printf("\nIndex %lu mismatched\n", i);
- exit(3);
- }
- printf("Done.\n");
- }
+ memset(ptr, 1, size);
  }

  if (want_sleep) {
@@ -253,7 +235,7 @@ int main(int argc, char **argv)
  sleep(100);
  }

- switch (method == HUGETLBFS) {
+ if (method == HUGETLBFS) {
  close(fd);
  }

--00000000000003c7ea059dc601fb
Content-Type: text/x-patch; charset="US-ASCII"; name="fix-ppc-hugetlb-test.patch"
Content-Disposition: attachment; filename="fix-ppc-hugetlb-test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k68c6d8o0>
X-Attachment-Id: f_k68c6d8o0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtL2NoYXJnZV9yZXNlcnZlZF9o
dWdldGxiLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdm0vY2hhcmdlX3Jlc2VydmVkX2h1
Z2V0bGIuc2gKaW5kZXggZWZkNjgwOTNjZTNlOS4uMThkMzM2ODRmYWFkZSAxMDA3NTUKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdm0vY2hhcmdlX3Jlc2VydmVkX2h1Z2V0bGIuc2gKKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdm0vY2hhcmdlX3Jlc2VydmVkX2h1Z2V0bGIuc2gK
QEAgLTE2OSwxOSArMTY5LDM2IEBAIGZ1bmN0aW9uIHdyaXRlX2h1Z2V0bGJmc19hbmRfZ2V0X3Vz
YWdlKCkgewogICBlY2hvIHJlc2VydmVkX3VzYWdlPSIkcmVzZXJ2ZWRfYmVmb3JlIgogICBlY2hv
IGV4cGVjdF9mYWlsdXJlIGlzICIkZXhwZWN0X2ZhaWx1cmUiCgorICBvdXRwdXQ9JChta3RlbXAp
CiAgIHNldCArZQogICBpZiBbWyAiJG1ldGhvZCIgPT0gIjEiIF1dIHx8IFtbICIkbWV0aG9kIiA9
PSAyIF1dIHx8CiAgICAgW1sgIiRwcml2YXRlIiA9PSAiLXIiIF1dICYmIFtbICIkZXhwZWN0X2Zh
aWx1cmUiICE9IDEgXV07IHRoZW4KCiAgICAgYmFzaCB3cml0ZV9odWdldGxiX21lbW9yeS5zaCAi
JHNpemUiICIkcG9wdWxhdGUiICIkd3JpdGUiIFwKLSAgICAgICIkY2dyb3VwIiAiJHBhdGgiICIk
bWV0aG9kIiAiJHByaXZhdGUiICItbCIgIiRyZXNlcnZlIiAmCisgICAgICAiJGNncm91cCIgIiRw
YXRoIiAiJG1ldGhvZCIgIiRwcml2YXRlIiAiLWwiICIkcmVzZXJ2ZSIgMj4mMSB8IHRlZSAkb3V0
cHV0ICYKCiAgICAgbG9jYWwgd3JpdGVfcmVzdWx0PSQ/CisgICAgbG9jYWwgd3JpdGVfcGlkPSQh
CgotICAgIGlmIFtbICIkcmVzZXJ2ZSIgIT0gIi1uIiBdXTsgdGhlbgotICAgICAgd2FpdF9mb3Jf
aHVnZXRsYl9tZW1vcnlfdG9fZ2V0X3Jlc2VydmVkICIkY2dyb3VwIiAiJHNpemUiCi0gICAgZWxp
ZiBbWyAiJHBvcHVsYXRlIiA9PSAiLW8iIF1dIHx8IFtbICIkd3JpdGUiID09ICItdyIgXV07IHRo
ZW4KKyAgICB1bnRpbCBncmVwIC1xIC1pICJET05FIiAkb3V0cHV0OyBkbworICAgICAgZWNobyB3
YWl0aW5nIGZvciBET05FIHNpZ25hbC4KKyAgICAgIGlmICEgcHMgJHdyaXRlX3BpZCA+IC9kZXYv
bnVsbAorICAgICAgdGhlbgorICAgICAgICBlY2hvICJGQUlMOiBUaGUgd3JpdGUgZGllZCIKKyAg
ICAgICAgY2xlYW51cAorICAgICAgICBleGl0IDEKKyAgICAgIGZpCisgICAgICBzbGVlcCAwLjUK
KyAgICBkb25lCisKKyAgICBlY2hvID09PT09PT09PT09PT09PT09IHdyaXRlX2h1Z2V0bGJfbWVt
b3J5LnNoIG91dHB1dCBpczoKKyAgICBjYXQgJG91dHB1dAorICAgIGVjaG8gPT09PT09PT09PT09
PT09PT0gZW5kIG91dHB1dC4KKworICAgIGlmIFtbICIkcG9wdWxhdGUiID09ICItbyIgXV0gfHwg
W1sgIiR3cml0ZSIgPT0gIi13IiBdXTsgdGhlbgogICAgICAgd2FpdF9mb3JfaHVnZXRsYl9tZW1v
cnlfdG9fZ2V0X3dyaXR0ZW4gIiRjZ3JvdXAiICIkc2l6ZSIKKyAgICBlbGlmIFtbICIkcmVzZXJ2
ZSIgIT0gIi1uIiBdXTsgdGhlbgorICAgICAgd2FpdF9mb3JfaHVnZXRsYl9tZW1vcnlfdG9fZ2V0
X3Jlc2VydmVkICIkY2dyb3VwIiAiJHNpemUiCiAgICAgZWxzZQogICAgICAgIyBUaGlzIGNhc2Ug
ZG9lc24ndCBwcm9kdWNlIHZpc2libGUgZWZmZWN0cywgYnV0IHdlIHN0aWxsIGhhdmUKICAgICAg
ICMgdG8gd2FpdCBmb3IgdGhlIGFzeW5jIHByb2Nlc3MgdG8gc3RhcnQgYW5kIGV4ZWN1dGUuLi4K
QEAgLTIyNyw3ICsyNDQsNyBAQCBmdW5jdGlvbiBjbGVhbnVwX2h1Z2V0bGJfbWVtb3J5KCkgewog
ICBzZXQgK2UKICAgbG9jYWwgY2dyb3VwPSIkMSIKICAgaWYgW1sgIiQocGdyZXAgLWYgd3JpdGVf
dG9faHVnZXRsYmZzKSIgIT0gIiIgXV07IHRoZW4KLSAgICBlY2hvIGtpbGluZyB3cml0ZV90b19o
dWdldGxiZnMKKyAgICBlY2hvIGtpbGxpbmcgd3JpdGVfdG9faHVnZXRsYmZzCiAgICAga2lsbGFs
bCAtMiB3cml0ZV90b19odWdldGxiZnMKICAgICB3YWl0X2Zvcl9odWdldGxiX21lbW9yeV90b19n
ZXRfZGVwbGV0ZWQgJGNncm91cAogICBmaQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdm0vd3JpdGVfdG9faHVnZXRsYmZzLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92
bS93cml0ZV90b19odWdldGxiZnMuYwppbmRleCA4NTgxMWMzMzg0YTEwLi43Zjc1YWQ1ZjdiNTgw
IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92bS93cml0ZV90b19odWdldGxi
ZnMuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92bS93cml0ZV90b19odWdldGxiZnMu
YwpAQCAtMjA3LDEzICsyMDcsMTMgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQog
CQl9CiAJCXByaW50Zigic2htaWQ6IDB4JXgsIHNobWdldCBrZXk6JWRcbiIsIHNobWlkLCBrZXkp
OwoKLQkJc2htYWRkciA9IHNobWF0KHNobWlkLCBOVUxMLCAwKTsKLQkJaWYgKHNobWFkZHIgPT0g
KGNoYXIgKiktMSkgeworCQlwdHIgPSBzaG1hdChzaG1pZCwgTlVMTCwgMCk7CisJCWlmIChwdHIg
PT0gKGludCAqKS0xKSB7CiAJCQlwZXJyb3IoIlNoYXJlZCBtZW1vcnkgYXR0YWNoIGZhaWx1cmUi
KTsKIAkJCXNobWN0bChzaG1pZCwgSVBDX1JNSUQsIE5VTEwpOwogCQkJZXhpdCgyKTsKIAkJfQot
CQlwcmludGYoInNobWFkZHI6ICVwXG4iLCBzaG1hZGRyKTsKKwkJcHJpbnRmKCJzaG1hZGRyOiAl
cFxuIiwgcHRyKTsKCiAJCWJyZWFrOwogCWRlZmF1bHQ6CkBAIC0yMjMsMjUgKzIyMyw3IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKCiAJaWYgKHdyaXRlKSB7CiAJCXByaW50Zigi
V3JpdGluZyB0byBtZW1vcnkuXG4iKTsKLQkJaWYgKG1ldGhvZCAhPSBTSE0pIHsKLQkJCW1lbXNl
dChwdHIsIDEsIHNpemUpOwotCQl9IGVsc2UgewotCQkJcHJpbnRmKCJTdGFydGluZyB0aGUgd3Jp
dGVzOlxuIik7Ci0JCQlmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSsrKSB7Ci0JCQkJc2htYWRkcltp
XSA9IChjaGFyKShpKTsKLQkJCQlpZiAoIShpICUgKDEwMjQgKiAxMDI0KSkpCi0JCQkJCXByaW50
ZigiLiIpOwotCQkJfQotCQkJcHJpbnRmKCJcbiIpOwotCi0JCQlwcmludGYoIlN0YXJ0aW5nIHRo
ZSBDaGVjay4uLiIpOwotCQkJZm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykKLQkJCQlpZiAoc2ht
YWRkcltpXSAhPSAoY2hhcilpKSB7Ci0JCQkJCXByaW50ZigiXG5JbmRleCAlbHUgbWlzbWF0Y2hl
ZFxuIiwgaSk7Ci0JCQkJCWV4aXQoMyk7Ci0JCQkJfQotCQkJcHJpbnRmKCJEb25lLlxuIik7Ci0J
CX0KKwkJbWVtc2V0KHB0ciwgMSwgc2l6ZSk7CiAJfQoKIAlpZiAod2FudF9zbGVlcCkgewpAQCAt
MjUzLDcgKzIzNSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJCXNsZWVw
KDEwMCk7CiAJfQoKLQlzd2l0Y2ggKG1ldGhvZCA9PSBIVUdFVExCRlMpIHsKKwlpZiAobWV0aG9k
ID09IEhVR0VUTEJGUykgewogCQljbG9zZShmZCk7CiAJfQo=
--00000000000003c7ea059dc601fb--
