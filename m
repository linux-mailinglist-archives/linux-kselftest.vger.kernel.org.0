Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2C5F3402
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Oct 2022 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJCQ7K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Oct 2022 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJCQ7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Oct 2022 12:59:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2946C31375;
        Mon,  3 Oct 2022 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=76WS+anvgXgculdAa3x2iWoi2sjt9hQeUGMZa9Q2m7E=; b=5Co+m++6+FUlHWOK6+QXnXS/e5
        wrWBH0Yf7dKMTFnTkOon89DUKZ5oCKKNmE6y7NyYHKFV+SBPgqfP1T6rd+wvC2OrcrBRL5C1l7Crv
        3Te1FrBWfEi09YIjuJ9LuWbZ7GyP4uB8m+WrOCtsT4WovCd1rkFZBkIgwYkMoZsXqDT2WK10KOz0z
        LafF6Jv2HhHYczletjB0ezT4Vy7rG8sCqgW0EFigWdRg2hB2bcNIogFJkmJeGmo/CEi221VAA6HiW
        etjoUvbAJXRgzigS9hpaX6G3wStx2IRGhFYdkQ3AiuWONoV80a5dFujnn212jXhL6WNXseepNGIb4
        jJTCOYeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofOmK-006xNL-Dc; Mon, 03 Oct 2022 16:58:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, keescook@chromium.org
Cc:     joe@perches.com, mcgrof@kernel.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH v11 1/2] LICENSES: Add the copyleft-next-0.3.1 license
Date:   Mon,  3 Oct 2022 09:58:48 -0700
Message-Id: <20221003165849.1658170-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221003165849.1658170-1-mcgrof@kernel.org>
References: <20221003165849.1658170-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the full text of the copyleft-next-0.3.1 license to the kernel
tree as well as the required tags for reference and tooling.
The license text was copied directly from the copyleft-next project's
git tree [0].

Discussion of using copyleft-next-0.3.1 on Linux started since June,
2016 [1]. In the end Linus' preference was to have drivers use
MODULE_LICENSE("GPL") to make it clear that the GPL applies when it
comes to Linux [2]. Additionally, even though copyleft-next-0.3.1 has
been found to be to be GPLv2 compatible by three attorneys at SUSE and
Redhat [3], to err on the side of caution we simply recommend to
always use the "OR" language for this license [4].

Even though it has been a goal of the project to be GPL-v2 compatible
to be certain in 2016 I asked for a clarification about what makes
copyleft-next GPLv2 compatible and also asked for a summary of
benefits. This prompted some small minor changes to make compatibility
even further clear and as of copyleft 0.3.1 compatibility should
be crystal clear [5].

The summary of why copyleft-next 0.3.1 is compatible with GPLv2
is explained as follows:

  Like GPLv2, copyleft-next requires distribution of derivative works
  ("Derived Works" in copyleft-next 0.3.x) to be under the same license.
  Ordinarily this would make the two licenses incompatible. However,
  copyleft-next 0.3.1 says: "If the Derived Work includes material
  licensed under the GPL, You may instead license the Derived Work under
  the GPL." "GPL" is defined to include GPLv2.

In practice this means copyleft-next code in Linux may be licensed
under the GPL2, however there are additional obvious gains for
bringing contributions from Linux outbound where copyleft-next is
preferred. A summary of benefits why projects outside of Linux might
prefer to use copyleft-next >= 0.3.1 over GPLv2:

o It is much shorter and simpler
o It has an explicit patent license grant, unlike GPLv2
o Its notice preservation conditions are clearer
o More free software/open source licenses are compatible
  with it (via section 4)
o The source code requirement triggered by binary distribution
  is much simpler in a procedural sense
o Recipients potentially have a contract claim against distributors
  who are noncompliant with the source code requirement
o There is a built-in inbound=outbound policy for upstream
  contributions (cf. Apache License 2.0 section 5)
o There are disincentives to engage in the controversial practice
  of copyleft/ proprietary dual-licensing
o In 15 years copyleft expires, which can be advantageous
  for legacy code
o There are explicit disincentives to bringing patent infringement
  claims accusing the licensed work of infringement (see 10b)
o There is a cure period for licensees who are not compliant
  with the license (there is no cure opportunity in GPLv2)
o copyleft-next has a 'built-in or-later' provision

The first driver submission to Linux under this dual strategy was
lib/test_sysctl.c through commit 9308f2f9e7f05 ("test_sysctl: add
dedicated proc sysctl test driver") merged in July 2017. Shortly after
that I also added test_kmod through commit d9c6a72d6fa29 ("kmod: add
test driver to stress test the module loader") in the same month. These
two drivers went in just a few months before the SPDX license practice
kicked in. In 2018 Kuno Woudt went through the process to get SPDX
identifiers for copyleft-next [6] [7]. Although there are SPDX tags
for copyleft-next-0.3.0, we only document use in Linux starting from
copyleft-next-0.3.1 which makes GPLv2 compatibility crystal clear.

This patch will let us update the two Linux selftest drivers in
subsequent patches with their respective SPDX license identifiers and
let us remove repetitive license boiler plate.

[0] https://github.com/copyleft-next/copyleft-next/blob/master/Releases/copyleft-next-0.3.1
[1] https://lore.kernel.org/lkml/1465929311-13509-1-git-send-email-mcgrof@kernel.org/
[2] https://lore.kernel.org/lkml/CA+55aFyhxcvD+q7tp+-yrSFDKfR0mOHgyEAe=f_94aKLsOu0Og@mail.gmail.com/
[3] https://lore.kernel.org/lkml/20170516232702.GL17314@wotan.suse.de/
[4] https://lkml.kernel.org/r/1495234558.7848.122.camel@linux.intel.com
[5] https://lists.fedorahosted.org/archives/list/copyleft-next@lists.fedorahosted.org/thread/JTGV56DDADWGKU7ZKTZA4DLXTGTLNJ57/#SQMDIKBRAVDOCT4UVNOOCRGBN2UJIKHZ
[6] https://spdx.org/licenses/copyleft-next-0.3.0.html
[7] https://spdx.org/licenses/copyleft-next-0.3.1.html

Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc: Kuno Woudt <kuno@frob.nl>
Cc: Richard Fontana <fontana@sharpeleven.org>
Cc: copyleft-next@lists.fedorahosted.org
Cc: Ciaran Farrell <Ciaran.Farrell@suse.com>
Cc: Christopher De Nicolo <Christopher.DeNicolo@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 LICENSES/dual/copyleft-next-0.3.1 | 236 ++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 LICENSES/dual/copyleft-next-0.3.1

diff --git a/LICENSES/dual/copyleft-next-0.3.1 b/LICENSES/dual/copyleft-next-0.3.1
new file mode 100644
index 000000000000..c81acf710657
--- /dev/null
+++ b/LICENSES/dual/copyleft-next-0.3.1
@@ -0,0 +1,236 @@
+Valid-License-Identifier: copyleft-next-0.3.1
+SPDX-URL: https://spdx.org/licenses/copyleft-next-0.3.1
+Usage-Guide:
+  copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
+  can therefore be used for kernel code. Though the best and recommended
+  practice is to express this in the SPDX license identifier by
+  licensing the code under both licenses expressed by the OR operator.
+  To use the copyleft-next-0.3.1 license put the following SPDX tag/value
+  pair into a comment according to the placement guidelines in the
+  licensing rules documentation:
+    SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
+    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
+License-Text:
+
+=======================================================================
+
+                      copyleft-next 0.3.1 ("this License")
+                            Release date: 2016-04-29
+
+1. License Grants; No Trademark License
+
+   Subject to the terms of this License, I grant You:
+
+   a) A non-exclusive, worldwide, perpetual, royalty-free, irrevocable
+      copyright license, to reproduce, Distribute, prepare derivative works
+      of, publicly perform and publicly display My Work.
+
+   b) A non-exclusive, worldwide, perpetual, royalty-free, irrevocable
+      patent license under Licensed Patents to make, have made, use, sell,
+      offer for sale, and import Covered Works.
+
+   This License does not grant any rights in My name, trademarks, service
+   marks, or logos.
+
+2. Distribution: General Conditions
+
+   You may Distribute Covered Works, provided that You (i) inform
+   recipients how they can obtain a copy of this License; (ii) satisfy the
+   applicable conditions of sections 3 through 6; and (iii) preserve all
+   Legal Notices contained in My Work (to the extent they remain
+   pertinent). "Legal Notices" means copyright notices, license notices,
+   license texts, and author attributions, but does not include logos,
+   other graphical images, trademarks or trademark legends.
+
+3. Conditions for Distributing Derived Works; Outbound GPL Compatibility
+
+   If You Distribute a Derived Work, You must license the entire Derived
+   Work as a whole under this License, with prominent notice of such
+   licensing. This condition may not be avoided through such means as
+   separate Distribution of portions of the Derived Work.
+
+   If the Derived Work includes material licensed under the GPL, You may
+   instead license the Derived Work under the GPL.
+   
+4. Condition Against Further Restrictions; Inbound License Compatibility
+
+   When Distributing a Covered Work, You may not impose further
+   restrictions on the exercise of rights in the Covered Work granted under
+   this License. This condition is not excused merely because such
+   restrictions result from Your compliance with conditions or obligations
+   extrinsic to this License (such as a court order or an agreement with a
+   third party).
+
+   However, You may Distribute a Covered Work incorporating material
+   governed by a license that is both OSI-Approved and FSF-Free as of the
+   release date of this License, provided that compliance with such
+   other license would not conflict with any conditions stated in other
+   sections of this License.
+
+5. Conditions for Distributing Object Code
+
+   You may Distribute an Object Code form of a Covered Work, provided that
+   you accompany the Object Code with a URL through which the Corresponding
+   Source is made available, at no charge, by some standard or customary
+   means of providing network access to source code.
+
+   If you Distribute the Object Code in a physical product or tangible
+   storage medium ("Product"), the Corresponding Source must be available
+   through such URL for two years from the date of Your most recent
+   Distribution of the Object Code in the Product. However, if the Product
+   itself contains or is accompanied by the Corresponding Source (made
+   available in a customarily accessible manner), You need not also comply
+   with the first paragraph of this section.
+
+   Each direct and indirect recipient of the Covered Work from You is an
+   intended third-party beneficiary of this License solely as to this
+   section 5, with the right to enforce its terms.
+
+6. Symmetrical Licensing Condition for Upstream Contributions
+
+   If You Distribute a work to Me specifically for inclusion in or
+   modification of a Covered Work (a "Patch"), and no explicit licensing
+   terms apply to the Patch, You license the Patch under this License, to
+   the extent of Your copyright in the Patch. This condition does not
+   negate the other conditions of this License, if applicable to the Patch.
+
+7. Nullification of Copyleft/Proprietary Dual Licensing
+
+   If I offer to license, for a fee, a Covered Work under terms other than
+   a license that is OSI-Approved or FSF-Free as of the release date of this
+   License or a numbered version of copyleft-next released by the
+   Copyleft-Next Project, then the license I grant You under section 1 is no
+   longer subject to the conditions in sections 3 through 5.
+
+8. Copyleft Sunset
+
+   The conditions in sections 3 through 5 no longer apply once fifteen
+   years have elapsed from the date of My first Distribution of My Work
+   under this License.
+
+9. Pass-Through
+
+   When You Distribute a Covered Work, the recipient automatically receives
+   a license to My Work from Me, subject to the terms of this License.
+
+10. Termination
+
+    Your license grants under section 1 are automatically terminated if You
+
+    a) fail to comply with the conditions of this License, unless You cure
+       such noncompliance within thirty days after becoming aware of it, or
+
+    b) initiate a patent infringement litigation claim (excluding
+       declaratory judgment actions, counterclaims, and cross-claims)
+       alleging that any part of My Work directly or indirectly infringes
+       any patent.
+
+    Termination of Your license grants extends to all copies of Covered
+    Works You subsequently obtain. Termination does not terminate the
+    rights of those who have received copies or rights from You subject to
+    this License.
+
+    To the extent permission to make copies of a Covered Work is necessary
+    merely for running it, such permission is not terminable.
+
+11. Later License Versions
+
+    The Copyleft-Next Project may release new versions of copyleft-next,
+    designated by a distinguishing version number ("Later Versions").
+    Unless I explicitly remove the option of Distributing Covered Works
+    under Later Versions, You may Distribute Covered Works under any Later
+    Version.
+
+** 12. No Warranty                                                       **
+**                                                                       **
+**     My Work is provided "as-is", without warranty. You bear the risk  **
+**     of using it. To the extent permitted by applicable law, each      **
+**     Distributor of My Work excludes the implied warranties of title,  **
+**     merchantability, fitness for a particular purpose and             **
+**     non-infringement.                                                 **
+
+** 13. Limitation of Liability                                           **
+**                                                                       **
+**     To the extent permitted by applicable law, in no event will any   **
+**     Distributor of My Work be liable to You for any damages           **
+**     whatsoever, whether direct, indirect, special, incidental, or     **
+**     consequential damages, whether arising under contract, tort       **
+**     (including negligence), or otherwise, even where the Distributor  **
+**     knew or should have known about the possibility of such damages.  **
+
+14. Severability
+
+    The invalidity or unenforceability of any provision of this License
+    does not affect the validity or enforceability of the remainder of
+    this License. Such provision is to be reformed to the minimum extent
+    necessary to make it valid and enforceable.
+
+15. Definitions
+
+    "Copyleft-Next Project" means the project that maintains the source
+    code repository at <https://github.com/copyleft-next/copyleft-next.git/>
+    as of the release date of this License.
+
+    "Corresponding Source" of a Covered Work in Object Code form means (i)
+    the Source Code form of the Covered Work; (ii) all scripts,
+    instructions and similar information that are reasonably necessary for
+    a skilled developer to generate such Object Code from the Source Code
+    provided under (i); and (iii) a list clearly identifying all Separate
+    Works (other than those provided in compliance with (ii)) that were
+    specifically used in building and (if applicable) installing the
+    Covered Work (for example, a specified proprietary compiler including
+    its version number). Corresponding Source must be machine-readable.
+
+    "Covered Work" means My Work or a Derived Work.
+
+    "Derived Work" means a work of authorship that copies from, modifies,
+    adapts, is based on, is a derivative work of, transforms, translates or
+    contains all or part of My Work, such that copyright permission is
+    required. The following are not Derived Works: (i) Mere Aggregation;
+    (ii) a mere reproduction of My Work; and (iii) if My Work fails to
+    explicitly state an expectation otherwise, a work that merely makes
+    reference to My Work.
+
+    "Distribute" means to distribute, transfer or make a copy available to
+    someone else, such that copyright permission is required.
+
+    "Distributor" means Me and anyone else who Distributes a Covered Work.
+
+    "FSF-Free" means classified as 'free' by the Free Software Foundation.
+
+    "GPL" means a version of the GNU General Public License or the GNU
+    Affero General Public License.
+
+    "I"/"Me"/"My" refers to the individual or legal entity that places My
+    Work under this License. "You"/"Your" refers to the individual or legal
+    entity exercising rights in My Work under this License. A legal entity
+    includes each entity that controls, is controlled by, or is under
+    common control with such legal entity. "Control" means (a) the power to
+    direct the actions of such legal entity, whether by contract or
+    otherwise, or (b) ownership of more than fifty percent of the
+    outstanding shares or beneficial ownership of such legal entity.
+
+    "Licensed Patents" means all patent claims licensable royalty-free by
+    Me, now or in the future, that are necessarily infringed by making,
+    using, or selling My Work, and excludes claims that would be infringed
+    only as a consequence of further modification of My Work.
+
+    "Mere Aggregation" means an aggregation of a Covered Work with a
+    Separate Work.
+
+    "My Work" means the particular work of authorship I license to You
+    under this License.
+
+    "Object Code" means any form of a work that is not Source Code.
+
+    "OSI-Approved" means approved as 'Open Source' by the Open Source
+    Initiative.
+
+    "Separate Work" means a work that is separate from and independent of a
+    particular Covered Work and is not by its nature an extension or
+    enhancement of the Covered Work, and/or a runtime library, standard
+    library or similar component that is used to generate an Object Code
+    form of a Covered Work.
+
+    "Source Code" means the preferred form of a work for making
+    modifications to it.
-- 
2.35.1

