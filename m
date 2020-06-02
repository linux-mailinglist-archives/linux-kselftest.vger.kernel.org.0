Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF21EC07C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBQzh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 12:55:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52830 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBQzh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 12:55:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052Gq51C058718;
        Tue, 2 Jun 2020 16:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=TgMIK/Li4+PJax3En9DWpNj9nLL9DF0CA9glXTSvvvI=;
 b=AZIrf0AQfHEfr1bKCmy8cfEsfA0Gq/tqVTMmNPNsASwlg1ITxEcBrf5+WX8ebSeyB+Vk
 LVkLwRMsB5EhXZwND6Wbrgt2STEor2DAohMnbp2W/AdeuD93wUozZF8JuSAdhx1pXqTN
 fgBKzD5smbLf5BKJdWfDXoiPtxm0L0Vm2sVKgxPSEnre2L/IJyVeW4Tcmo6QnwX71f1z
 ELEWygDQB78eiX6DGLBSA2zypg/cijlWz4RgDklwxxVV02fmaeVtAvxqj+iBzZIrhwpN
 WMZ/dUqwdiTFGtAccByXHHR49v8xhFtABWCdCPMKxP3bBB0kfgxDGc+EHGgejHMlFJ1z 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31dkruj55h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 16:55:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052GrFZc129851;
        Tue, 2 Jun 2020 16:53:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31c1dxk3qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 16:53:32 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052GrVDF004497;
        Tue, 2 Jun 2020 16:53:31 GMT
Received: from dhcp-10-175-162-197.vpn.oracle.com (/10.175.162.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 09:53:30 -0700
Date:   Tue, 2 Jun 2020 17:53:27 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     David Gow <davidgow@google.com>
cc:     Brendan Higgins <brendanhiggins@google.com>,
        alan.maguire@oracle.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kunit: Add some troubleshooting tips to
 the FAQ
In-Reply-To: <20200602054216.93122-1-davidgow@google.com>
Message-ID: <alpine.LRH.2.21.2006021743430.17227@localhost>
References: <20200602054216.93122-1-davidgow@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020121
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 1 Jun 2020, David Gow wrote:

> Add an FAQ entry to the KUnit documentation with some tips for
> troubleshooting KUnit and kunit_tool.
> 
> These suggestions largely came from an email thread:
> https://lore.kernel.org/linux-kselftest/41db8bbd-3ba0-8bde-7352-083bf4b947ff@intel.com/T/#m23213d4e156db6d59b0b460a9014950f5ff6eb03
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/kunit/faq.rst | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
> index ea55b2467653..40109d425988 100644
> --- a/Documentation/dev-tools/kunit/faq.rst
> +++ b/Documentation/dev-tools/kunit/faq.rst
> @@ -61,3 +61,35 @@ test, or an end-to-end test.
>    kernel by installing a production configuration of the kernel on production
>    hardware with a production userspace and then trying to exercise some behavior
>    that depends on interactions between the hardware, the kernel, and userspace.
> +
> +KUnit isn't working, what should I do?
> +======================================
> +
> +Unfortunately, there are a number of things which can break, but here are some
> +things to try.
> +
> +1. Try running ``./tools/testing/kunit/kunit.py run`` with the ``--raw_output``
> +   parameter. This might show details or error messages hidden by the kunit_tool
> +   parser.
> +2. Instead of running ``kunit.py run``, try running ``kunit.py config``,
> +   ``kunit.py build``, and ``kunit.py exec`` independently. This can help track
> +   down where an issue is occurring. (If you think the parser is at fault, you
> +   can run it manually against stdin or a file with ``kunit.py parse``.)
> +3. Running the UML kernel directly can often reveal issues or error messages
> +   kunit_tool ignores. This should be as simple as running ``./vmlinux`` after
> +   building the UML kernel (e.g., by using ``kunit.py build``). Note that UML
> +   has some unusual requirements (such as the host having a tmpfs filesystem
> +   mounted), and has had issues in the past when built statically and the host
> +   has KASLR enabled. (On older host kernels, you may need to run ``setarch
> +   `uname -m` -R ./vmlinux`` to disable KASLR.)
> +4. Make sure the kernel .config has ``CONFIG_KUNIT=y`` and at least one test
> +   (e.g. ``CONFIG_KUNIT_EXAMPLE_TEST=y``). kunit_tool will keep its .config
> +   around, so you can see what config was used after running ``kunit.py run``.
> +   It also preserves any config changes you might make, so you can
> +   enable/disable things with ``make ARCH=um menuconfig`` or similar, and then
> +   re-run kunit_tool.
> +5. Finally, running ``make ARCH=um defconfig`` before running ``kunit.py run``
> +   may help clean up any residual config items which could be causing problems.
> +

Looks great! Could we add something like:

6. Try running kunit standalone (without UML).  KUnit and associated 
tests can be built into a standard kernel or built as a module; doing
so allows us to verify test behaviour independent of UML so can be
useful to do if running under UML is failing.  When tests are built-in
they will execute on boot, and modules will automatically execute
associated tests when loaded.  Test results can be collected from
/sys/kernel/debug/kunit/<test-suite>/results. For more details see
"KUnit on non-UML architectures" in :doc:`usage`. 

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
