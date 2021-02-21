Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C06320D8A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Feb 2021 21:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBUUTG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Feb 2021 15:19:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:48833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhBUUTF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Feb 2021 15:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613938631;
        bh=cFGcwB+oIMoQD2nm971NYoY7QQ0QXu1e9XPHJAzwb7k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GOZwDesgWdfw4DZi7UV0SSNxWXqWTaptbzoRgQq/dOd+ZSmTmVKCJj5Zm9l0x7Uks
         ZFDoacsmwJQMbMZImrM3XVv7ODwsjhmvAQaWact2YeTIQG8k+NmIC1CAXjYP8YOpYA
         xzTn2vTksJsdIuiDFDno8FDV3C94wNqyAUagcA44=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MplXz-1ldI6c2LhF-00qEN2; Sun, 21 Feb 2021 21:17:11 +0100
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
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 8/8] MAINTAINERS: Add a new entry for the Brute LSM
Date:   Sun, 21 Feb 2021 16:49:19 +0100
Message-Id: <20210221154919.68050-9-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210221154919.68050-1-john.wood@gmx.com>
References: <20210221154919.68050-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A9lV3V9nsLMCf5CmMu6k/qVFGT1BkfgTJJSixdrK1IpFF6pUB7/
 peNPmEQle3ecEnl7Bk6MLydWlFKHNCF7Fzm8lkP9Vv5TR7vuedJis7NBbrz6WXPwAMNmtnC
 zdnbYQ9+zGzQlaSIt4JlxwSK4lg/pdpElRrY/c203DLGnQFE16MLhZdE1jJmWGAWY6TqxYD
 ZrIGTZhAjXr/UJ9yfMS3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MM733bPvwtU=:tsjxnsOkeC5P2GMTGa4ajS
 XPH1WOi3gOxUnh1Zk8XgsE/gheE3qzBqu0wpZdjzHwOJoUaHitd6jn6B711VuRlq1t0Xsn4Kq
 gZReMFfirnCNVrL+UVzx9SmD7Vrfa6fuJtPIk3VOe8kPu+1Ac7PKZ/h46FvNEJEJPmTVeOFVE
 9nlqNuPKlH4Z/31jN8j5BbUvJIphjMr3KQ7fPIQP2znm8K90lBUR5/AAPhC07jrkgxaUKO/2a
 SH3WtcrX+J7xPY7mgPGCCNwz4Lp4o2zXhv2Zx9LAxZpnS+xFBhQYaHTg07LrQAK7B7QPMtkc3
 Pxanl08Z700pqccI4ALdspjqtUrpMQMUtFLdKZ9p1+ZGDqwk14jQVGqafsQp50GnqKm/yFoaT
 TH8ST0/kDC831b6BvHkitx/iqhmDQvVljGqlXWqSCF/+Z+nZSfgWZa/taJB6Ot0fFicNvuJ7s
 gE8wtxOm/n1anWlGPhqmeBSeiudrcIF8kT2H/Q4PbMXus3Wqzwxe7cCC0HCJYCMlCpaaC32dC
 RAkgqEGi39VdLlsvLpc5bk/BMzyks7B0+IP4VPO1ewId0lxytyAqNxx/Y1hOA5dkiPO7of2Fg
 iproAeTELRRF+4dqU2JL/FSKlAuSDcGIT6jXN6X8IQFf30Dsv07dYYOJxf9N49EpsVZOVxeLL
 dx621j4LVw52JkTVToYVOVSd0fXvx4JQgaU/AYdv9/in3rTz9GUfu6pnYb7p7aAPcy2Q+DICM
 CZQJCaDuFg5vvxlecRE/mOkApyK3r3ZuMF5b53xforWIxLPTW+3JVXTGtfHxyuYyH17XZ+M5y
 TWO54IvBjlu1APw3zoqqDHC3we1y5f33bhLhp7TrWRgUVKL2Q0JYTTXvf7XCtb5cdZhN0oIJ7
 PBo417v0KOadm/NriYTg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to maintain the code for the Brute LSM add a new entry to the
maintainers list.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfc1b86e3e73..a88327198474 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3760,6 +3760,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/brocade/bna/

+BRUTE SECURITY MODULE
+M:	John Wood <john.wood@gmx.com>
+S:	Maintained
+F:	Documentation/admin-guide/LSM/Brute.rst
+F:	security/brute/
+F:	tools/testing/selftests/brute/
+
 BSG (block layer generic sg v4 driver)
 M:	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
 L:	linux-scsi@vger.kernel.org
=2D-
2.25.1

