Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F73BEF9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 20:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhGGSqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 14:46:02 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:54260 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhGGSqB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 14:46:01 -0400
Received: by mail-pj1-f50.google.com with SMTP id p9so2066968pjl.3;
        Wed, 07 Jul 2021 11:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYHEwmGX1lAy4agtrMpwVXBsdxMt3sdlA/i5qx4wo1Q=;
        b=bng3bTBUMe8jlFQ4moF2FyYxOKNelBOVuY/1+fSUyruBsK82BwZ8XxmV0yGaNAWVPU
         ok3JjMy7fUeLzMqsULQY4My9O8CWrDLHRapRb7zM6nYzkAH++2ZjxyVWXQbGLpDniC2Y
         NcYNeeKkte+uCOZEbjkQekkGkzAYCuWXVU7BHNZoa6t3N1KV3Y6PlvXTuObwZSJbVfZO
         JWBy55VAkkxAXfuCj3qNElrxJzsw7weNh8j/h14HX9qAemErlyVlXPJFB+fwE+XOVFVt
         ODiJR9nQ4OZYh1VTiLYXSVPJQzaJ+KMK9ewnfwNGbq/AOIQBaiRgqNyIcXV6hBOC7a2c
         +z0Q==
X-Gm-Message-State: AOAM530UrNmIKAG3HNVEtMN3ZlHRVx2Jktmc8kT5AjBkYYo58Ho/yhTz
        yHNqk0AtV9ODXV5R23fGDx4=
X-Google-Smtp-Source: ABdhPJzkl5e+Yb40EaIFnUwPobht+HsYSI+i7HkkmvogICdyH5jF+UGpO7oHoxBYjla9az+PoaoBvg==
X-Received: by 2002:a17:902:d2c4:b029:129:7b5b:f30f with SMTP id n4-20020a170902d2c4b02901297b5bf30fmr17279665plc.30.1625683400943;
        Wed, 07 Jul 2021 11:43:20 -0700 (PDT)
Received: from localhost ([191.96.120.45])
        by smtp.gmail.com with ESMTPSA id md15sm7481597pjb.30.2021.07.07.11.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 11:43:20 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     rafael@kernel.org, rgoldwyn@suse.com, kuno@frob.nl,
        fontana@sharpeleven.org, Ciaran.Farrell@suse.com,
        Christopher.DeNicolo@suse.com, hch@lst.de, corbet@lwn.net,
        linux@leemhuis.info, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, tj@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-spdx@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        copyleft-next@lists.fedorahosted.org
Subject: [PATCH 1/2] LICENSES: Add the copyleft-next-0.3.1 license
Date:   Wed,  7 Jul 2021 11:43:09 -0700
Message-Id: <20210707184310.3624761-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707184310.3624761-1-mcgrof@kernel.org>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 LICENSES/dual/copyleft-next-0.3.1 | 237 ++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 LICENSES/dual/copyleft-next-0.3.1

diff --git a/LICENSES/dual/copyleft-next-0.3.1 b/LICENSES/dual/copyleft-next-0.3.1
new file mode 100644
index 000000000000..086bcb74b478
--- /dev/null
+++ b/LICENSES/dual/copyleft-next-0.3.1
@@ -0,0 +1,237 @@
+Valid-License-Identifier: copyleft-next-0.3.1
+SPDX-URL: https://spdx.org/licenses/copyleft-next-0.3.1
+Usage-Guide:
+  This license can be used in code, it has been found to be GPLv2 compatible
+  by attorneys at Redhat and SUSE, however to air on the side of caution,
+  it's best to only use it together with a GPL2 compatible license using "OR".
+  To use the copyleft-next-0.3.1 license put the following SPDX tag/value
+  pair into a comment according to the placement guidelines in the
+  licensing rules documentation:
+    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1
+    SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
+    SPDX-License-Identifier: GPL-2.0+ OR copyleft-next-0.3.1
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
2.27.0

