Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7E3D8E54
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhG1Mye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 08:54:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3515 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhG1Myd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 08:54:33 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZYKS2dZZz6DJHd;
        Wed, 28 Jul 2021 20:45:16 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 14:54:30 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Wed, 28 Jul 2021 14:54:30 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH v2 11/12] diglim: Remote Attestation
Thread-Topic: [RFC][PATCH v2 11/12] diglim: Remote Attestation
Thread-Index: AQHXgjz9ODHmd+8DTkOcoAaHmj57yatYN3AAgAAjKjA=
Date:   Wed, 28 Jul 2021 12:54:30 +0000
Message-ID: <3ed8744299814d238c73d26a9fb9f745@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
        <20210726163700.2092768-12-roberto.sassu@huawei.com>
 <20210728144728.62ace280@sal.lan>
In-Reply-To: <20210728144728.62ace280@sal.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Mauro Carvalho Chehab [mailto:mchehab+huawei@kernel.org]
> Sent: Wednesday, July 28, 2021 2:47 PM
> Em Mon, 26 Jul 2021 18:36:59 +0200
> Roberto Sassu <roberto.sassu@huawei.com> escreveu:
> 
> > Add more information about remote attestation with IMA and DIGLIM in
> > Documentation/security/diglim/remote_attestation.rst.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  Documentation/security/diglim/index.rst       |  1 +
> >  .../security/diglim/remote_attestation.rst    | 87 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  3 files changed, 89 insertions(+)
> >  create mode 100644 Documentation/security/diglim/remote_attestation.rst
> >
> > diff --git a/Documentation/security/diglim/index.rst
> b/Documentation/security/diglim/index.rst
> > index 4771134c2f0d..0f28c5ad71c0 100644
> > --- a/Documentation/security/diglim/index.rst
> > +++ b/Documentation/security/diglim/index.rst
> > @@ -10,3 +10,4 @@ Digest Lists Integrity Module (DIGLIM)
> >     introduction
> >     architecture
> >     implementation
> > +   remote_attestation
> > diff --git a/Documentation/security/diglim/remote_attestation.rst
> b/Documentation/security/diglim/remote_attestation.rst
> > new file mode 100644
> > index 000000000000..83fd7581c460
> > --- /dev/null
> > +++ b/Documentation/security/diglim/remote_attestation.rst
> > @@ -0,0 +1,87 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Remote Attestation
> > +==================
> > +
> > +When a digest list is added or deleted through the ``digest_list_add`` or
> > +``digest_list_del`` interfaces, its buffer is sent to the IMA function
> > +``ima_measure_critical_data()``. The primary reason for it is to calculate
> > +the buffer digest, so that the digest list itself is searchable in the hash
> > +table.
> > +
> > +``ima_measure_critical_data()`` can be also used to create a new
> > +measurement entry each time this function is called, if there is an
> > +appropriate rule in the IMA policy. Given that this function is called
> > +during an addition or deletion of a digest list, a remote verifier can
> > +infer from the measurement list precise information about what has been
> > +uploaded to the kernel.
> > +
> > +To enable this functionality, the following rule must be added to the IMA
> > +policy:
> > +
> > +::
> 
> As commented on other patches at this series, you can merge :: at the
> previous text line, e. g.:
> 
> 	policy::
> 
> does the same as:
> 
> 	policy:
> 
> 	::
> 
> but it is nicer for text-only readers, IMO.

Ok, will change in the next version of the patch set.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> > +
> > + measure func=CRITICAL_DATA label=diglim
> > +
> > +
> > +When a file is uploaded, the workflow and the resulting IMA measurement
> > +list are:
> > +
> > +.. code-block:: bash
> > +
> > + # echo $PWD/0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_list_add
> > + # echo $PWD/0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_list_del
> > + # cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> > + ...
> > + 10 <template digest> ima-buf sha256:<buffer digest> add_file_0-file_list-
> compact-cat <buffer>
> > + 10 <template digest> ima-buf sha256:<buffer digest> del_file_0-file_list-
> compact-cat <buffer>
> > +
> > +When a buffer is uploaded, the workflow and the resulting IMA
> measurement
> > +list are:
> > +
> > +.. code-block:: bash
> > +
> > + # echo 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_label
> > + # cat 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_list_add
> > + # echo 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_label
> > + # cat 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_list_del
> > + # cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> > + ...
> > + 10 <template digest> ima-buf sha256:<buffer digest> add_buffer_0-
> file_list-compact-cat <buffer>
> > + 10 <template digest> ima-buf sha256:<buffer digest> del_buffer_0-file_list-
> compact-cat <buffer>
> > +
> > +In the second case, the digest list label must be set explicitly, as the
> > +kernel cannot determine it by itself (in the first case it is derived from
> > +the name of the file uploaded).
> > +
> > +The confirmation that the digest list has been processed by IMA can be
> > +obtained by reading the ASCII representation of the digest list:
> > +
> > +.. code-block:: bash
> > +
> > + # cat /sys/kernel/security/integrity/diglim/digest_lists_loaded/sha256-
> <digest list digest>-0-file_list-compact-cat.ascii
> > + actions: 1, version: 1, algo: sha256, type: 2, modifiers: 1, count: 1, datalen:
> 32
> > +
> 87e5bd81850e11eeec2d3bb696b626b2a7f45673241cbbd64769c83580432869
> > +
> > +In this output, ``actions`` is set to 1
> (``COMPACT_ACTION_IMA_MEASURED``
> > +bit set).
> > +
> > +
> > +DIGLIM guarantees that the information reported in the IMA measurement
> list
> > +is complete. If digest list loading is not recorded, digest query results
> > +are ignored by IMA. If the addition was recorded, deletion can be
> performed
> > +only if also the deletion is recorded. This can be seen in the following
> > +sequence of commands:
> > +
> > +.. code-block:: bash
> > +
> > + # echo 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_label
> > + # cat 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_list_add
> > + # echo 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_label
> > + # /tmp/cat 0-file_list-compact-cat >
> /sys/kernel/security/integrity/diglim/digest_list_del
> > + diglim: actions mismatch, add: 1, del: 0
> > + diglim: unable to upload generated digest list
> > + /tmp/cat: write error: Invalid argument
> > +
> > +Digest list measurement is avoided with the execution of ``/tmp/cat``, for
> > +which a dont_measure rule was previously added in the IMA policy.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0672128fae7f..a7c502685109 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5461,6 +5461,7 @@ F:
> 	Documentation/security/diglim/architecture.rst
> >  F:	Documentation/security/diglim/implementation.rst
> >  F:	Documentation/security/diglim/index.rst
> >  F:	Documentation/security/diglim/introduction.rst
> > +F:	Documentation/security/diglim/remote_attestation.rst
> >  F:	include/linux/diglim.h
> >  F:	include/uapi/linux/diglim.h
> >  F:	security/integrity/diglim/diglim.h
