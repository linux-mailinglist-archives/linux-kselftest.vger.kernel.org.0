Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE43D8C7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 13:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhG1LKK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 07:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhG1LKI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 07:10:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1672260F9C;
        Wed, 28 Jul 2021 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627470607;
        bh=V2NQxQh4OkMBeksIOPX7iWbdoL9UHPP+Sx9ZO5cjjPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cSkOXaQbN/7llO6azKkF6gK7pZZCFVxu4cEweAXZRG6aDFspJBdduIr5ezeoAtXgT
         75uyYYZZcgJbfkcSDkHH8HuXFKsu/jpHwkpYSFYHxFas0M9rf2vxXetRFonavKGodf
         h117IOt4oPFyUwv28rkuMlRqpLBvFddjw3meRegKtuar9XhUrBEsx0iz8oLbQoOwMB
         NP+NxwmQrAQsKBZzQJkLXQq3Q8n1nx+T1JUYpx4lXGub79lUgnEUL01cHWSGrsThsc
         QM4rIetigR+YD+55x7IsXUSS8EjEmJZdwvr8LCEaRsXI2+2Lt8D/JofYtbaxlvjd2b
         5Z3EHXI7VoD3w==
Date:   Wed, 28 Jul 2021 13:10:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 01/12] diglim: Overview
Message-ID: <20210728131000.16788919@coco.lan>
In-Reply-To: <20210726163700.2092768-2-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
        <20210726163700.2092768-2-roberto.sassu@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Mon, 26 Jul 2021 18:36:49 +0200
Roberto Sassu <roberto.sassu@huawei.com> escreveu:

> Add an overview of DIGLIM to Documentation/security/diglim/introduction.rst
> and the architecture to Documentation/security/diglim/architecture.rst
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../security/diglim/architecture.rst          |  45 ++
>  Documentation/security/diglim/index.rst       |  11 +
>  .../security/diglim/introduction.rst          | 631 ++++++++++++++++++
>  Documentation/security/index.rst              |   1 +
>  MAINTAINERS                                   |   9 +
>  5 files changed, 697 insertions(+)
>  create mode 100644 Documentation/security/diglim/architecture.rst
>  create mode 100644 Documentation/security/diglim/index.rst
>  create mode 100644 Documentation/security/diglim/introduction.rst
> 
> diff --git a/Documentation/security/diglim/architecture.rst b/Documentation/security/diglim/architecture.rst
> new file mode 100644
> index 000000000000..a54fe2453715
> --- /dev/null
> +++ b/Documentation/security/diglim/architecture.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Architecture
> +============
> +
> +This section introduces the high level architecture of DIGLIM.
> +
> +::
> +
> + 5. add/delete from hash table and add refs to digest list
> +        +---------------------------------------------+
> +        |                            +-----+   +-------------+         +--+
> +        |                            | key |-->| digest refs |-->...-->|  |
> +        V                            +-----+   +-------------+         +--+
> + +-------------+                     +-----+   +-------------+
> + | digest list |                     | key |-->| digest refs |
> + |  (compact)  |                     +-----+   +-------------+
> + +-------------+                     +-----+   +-------------+
> +        ^ 4. copy to                 | key |-->| digest refs |
> +        |    kernel memory           +-----+   +-------------+ kernel space
> + --------------------------------------------------------------------------
> +        ^                                          ^             user space
> +        |<----------------+       3b. upload       |
> + +-------------+   +------------+                  | 6. query digest
> + | digest list |   | user space | 2b. convert
> + |  (compact)  |   |   parser   |
> + +-------------+   +------------+
> + 1a. upload               ^       1b. read
> +                          |
> +                   +------------+
> +                   | RPM header |
> +                   +------------+
> +
> +
> +As mentioned before, digest lists can be uploaded directly if they are in

"before"? This is at the beginning of this document ;-)

You should probably add a reference to introduction.rst here, like:

	As mentioned at Documentation/security/diglim/introduction.rst, ...


> +the compact format (step 1a) or can be uploaded indirectly by the user
> +space parser if they are in an alternative format (steps 1b-3b).
> +
> +During upload, the kernel makes a copy of the digest list to the kernel
> +memory (step 4), and creates the necessary structures to index the digests
> +(hash table and a linked list of digest list references to locate the
> +digests in the digest list) (step 5).
> +
> +Finally, digests can be searched from user space through a securityfs file
> +(step 6) or by the kernel itself.

This probably applies to Documentation/security as a hole, but the
best is to split the documents on two separate parts:
	- the kAPI and internals;
	- the admin-guide part.

The audience for the admin-guide is distribution pagagers and
syssadmins.

> diff --git a/Documentation/security/diglim/index.rst b/Documentation/security/diglim/index.rst
> new file mode 100644
> index 000000000000..0fc5ab019bc0
> --- /dev/null
> +++ b/Documentation/security/diglim/index.rst
> @@ -0,0 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Digest Lists Integrity Module (DIGLIM)
> +======================================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   introduction
> +   architecture
> diff --git a/Documentation/security/diglim/introduction.rst b/Documentation/security/diglim/introduction.rst
> new file mode 100644
> index 000000000000..d8d8b2a17222
> --- /dev/null
> +++ b/Documentation/security/diglim/introduction.rst
> @@ -0,0 +1,631 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Introduction
> +============
> +
> +Digest Lists Integrity Module (DIGLIM) is a new component added to the
> +integrity subsystem in the kernel, primarily aiming to aid Integrity

I would replace:

	"is a new component added to" -> "is a component of"

As this is the kind of text that tends to be outdated with time...
Imagine someone reading this paragraph maybe 10 years in the future ;-)

> +Measurement Architecture (IMA) in the process of checking the integrity of
> +file content and metadata. It accomplishes this task by storing reference
> +values coming from software vendors and by reporting whether or not the
> +digest of file content or metadata calculated by IMA (or EVM) is found
> +among those values. In this way, IMA can decide, depending on the result of
> +a query, if a measurement should be taken or access to the file should be
> +granted. The `Security Assumptions`_ section explains more in detail why
> +this component has been placed in the kernel.
> +
> +The main benefits of using IMA in conjunction with DIGLIM are the ability
> +to implement advanced remote attestation schemes based on the usage of a
> +TPM key for establishing a TLS secure channel [1][2], and to reduce the
> +burden on Linux distribution vendors to extend secure boot at OS level to
> +applications.
> +
> +DIGLIM does not have the complexity of feature-rich databases. In fact, its
> +main functionality comes from the hash table primitives already in the
> +kernel. It does not have an ad-hoc storage module, it just indexes data in
> +a fixed format (digest lists, a set of concatenated digests preceded by a
> +header), copied to kernel memory as they are. Lastly, it does not support
> +database-oriented languages such as SQL, but only accepts a digest and its
> +algorithm as a query.
> +
> +The only digest list format supported by DIGLIM is called ``compact``.
> +However, Linux distribution vendors don't have to generate new digest lists
> +in this format for the packages they release, as already available
> +information, such as RPM headers and DEB package metadata, can be already
> +used as a source for reference values (they already include file digests),

	-ETOMANY_already

as "already" available... can be "already" ... "already" include...

I would simplify the above text removing such redundancy.

> +with a user space parser taking care of the conversion to the compact
> +format.
> +
> +Although one might perceive that storing file or metadata digests for a
> +Linux distribution would significantly increase the memory usage, this does
> +not seem to be the case. As an anticipation of the evaluation done in the
> +`Preliminary Performance Evaluation`_ section, protecting binaries and
> +shared libraries of a minimal Fedora 33 installation requires 208K of
> +memory for the digest lists plus 556K for indexing.
> +


> +In exchange for a slightly increased memory usage, DIGLIM improves the
> +performance of the integrity subsystem. In the considered scenario, IMA
> +measurement and appraisal with digest lists requires respectively less than
> +one quarter and less than half the time, compared to the current solution.

I found this paragraph a little bit confusing to understand. Could you
please improve the description?

I mean: 

	what improved by one quarter?
	what improved by "less than half of the time"?

> +
> +DIGLIM also keeps track of whether digest lists have been processed in some
> +way (e.g. measured or appraised by IMA). This is important for example for
> +remote attestation, so that remote verifiers understand what has been
> +uploaded to the kernel.
> +

> +DIGLIM behaves like a transactional database, i.e. it has the ability to
> +roll back to the beginning of the transaction if an error occurred during
> +the addition of a digest list (the deletion operation always succeeds).

I don't think it makes sense to compare it with a transactional database.

I would say, instead, something like:

	The inserts on DIGLIM are atomic: if an error occurs during the addition
	of a digest list, it rolls back the entire insert operation.


> +This capability has been tested with an ad-hoc fault injection mechanism
> +capable of simulating failures during the operations.
> +
> +Finally, DIGLIM exposes to user space, through securityfs, the digest lists
> +currently loaded, the number of digests added, a query interface and an
> +interface to set digest list labels.
> +
> +[1] LSS EU 2019
> +
> +-   slides:
> +    https://static.sched.com/hosted_files/lsseu2019/bd/secure_attested_communication_channels_lss_eu_2019.pdf
> +-   video: https://youtu.be/mffdQgkvDNY
> +
> +[2] FutureTPM EU project, final review meeting demo
> +
> +-   slides:
> +    https://futuretpm.eu/images/07-3-FutureTPM-Final-Review-Slides-WP6-Device-Management-Use-Case-HWDU.pdf
> +-   video: https://vimeo.com/528251864/4c1d55abcd

The above won't generate any cross-references with Sphinx.

For it correct syntax, see:
	https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#citations


> +
> +
> +Binary Integrity
> +----------------
> +
> +Integrity is a fundamental security property in information systems.

> +Integrity could be described as the condition in which a generic
> +component is just after it has been released by the entity that created it.

Sounds a weird description for me. (ISC)2 defines integrity on its
glossary[1] as:

	"Guarding against improper information modification or destruction and
	 includes ensuring information non-repudiation and authenticity."

[1] https://www.isc2.org/Certifications/CISSP/CISSP-Student-Glossary

> +One way to check whether a component is in this condition (called binary
> +integrity) is to calculate its digest and to compare it with a reference
> +value (i.e. the digest calculated in controlled conditions, when the
> +component is released).
> +
> +IMA, a software part of the integrity subsystem, can perform such
> +evaluation and execute different actions:
> +
> +- store the digest in an integrity-protected measurement list, so that it
> +  can be sent to a remote verifier for analysis;
> +- compare the calculated digest with a reference value (usually protected
> +  with a signature) and deny operations if the file is found corrupted;
> +- store the digest in the system log.
> +
> +


> +Contribution
> +------------

I would rename this chapter to "Benefits".

> +
> +DIGLIM further enhances the capabilities offered by IMA-based solutions
> +and, at the same time, makes them more practical to adopt by reusing
> +existing sources as reference values for integrity decisions.
> +
> +Possible sources for digest lists are:
> +
> +- RPM headers;
> +- Debian repository metadata.
> +
> +
> +Benefits for IMA Measurement
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +One of the issues that arises when files are measured by the OS is that,
> +due to parallel execution, the order in which file accesses happen cannot
> +be predicted. Since the TPM Platform Configuration Register (PCR) extend
> +operation, executed after each file measurement, cryptographically binds
> +the current measurement to the previous ones, the PCR value at the end of a
> +workload cannot be predicted too.
> +
> +Thus, even if the usage of a TPM key, bound to a PCR value, should be
> +allowed when only good files were accessed, the TPM could unexpectedly deny
> +an operation on that key if files accesses did not happen as stated by the
> +key policy (which allows only one of the possible sequences).
> +
> +DIGLIM solves this issue by making the PCR value stable over the time and
> +not dependent on file accesses. The following figure depicts the current
> +and the new approaches:
> +
> +::
> +
> + IMA measurement list (current)
> +
> + entry#        1st boot               2nd boot               3rd boot
> +       +----+---------------+ +----+---------------+ +----+---------------+
> + 1:    | 10 | file1 measur. | | 10 | file3 measur. | | 10 | file2 measur. |
> +       +----+---------------+ +----+---------------+ +----+---------------+
> + 2:    | 10 | file2 measur. | | 10 | file2 measur. | | 10 | file3 measur. |
> +       +----+---------------+ +----+---------------+ +----+---------------+
> + 3:    | 10 | file3 measur. | | 10 | file1 measur. | | 10 | file4 measur. |
> +       +----+---------------+ +----+---------------+ +----+---------------+
> +
> + PCR:  Extend              != Extend              != Extend
> +       file1, file2, file3    file3, file2, file1    file2, file3, file4
> +
> +
> + PCR Extend definition:
> +
> +       PCR(new value) = Hash(Hash(meas. entry), PCR(previous value))
> +
> +A new entry in the measurement list is created by IMA for each file access.
> +Assuming that ``file1``, ``file2`` and ``file3`` are files provided by the
> +software vendor, ``file4`` is an unknown file, the first two PCR values
> +above represent a good system state, the third a bad system state. The PCR
> +values are the result of the PCR extend operation performed for each
> +measurement entry with the digest of the measurement entry as an input.
> +
> +::
> +
> + IMA measurement list (with DIGLIM)
> +
> + dlist
> + +--------------+
> + |    header    |
> + +--------------+
> + | file1 digest |
> + | file2 digest |
> + | file3 digest |
> + +--------------+
> +
> +``dlist`` is a digest list containing the digest of ``file1``, ``file2``
> +and ``file3``. In the intended scenario, it is generated by a software
> +vendor at the end of the building process, and retrieved by the
> +administrator of the system where the digest list is loaded.
> +
> +::
> +
> + entry#        1st boot               2nd boot               3rd boot
> +       +----+---------------+ +----+---------------+ +----+---------------+
> + 0:    | 11 | dlist measur. | | 11 | dlist measur. | | 11 | dlist measur. |
> +       +----+---------------+ +----+---------------+ +----+---------------+
> + 1:    < file1 measur. skip > < file3 measur. skip > < file2 measur. skip >
> +
> + 2:    < file2 measur. skip > < file2 measur. skip > < file3 measur. skip >
> +                                                     +----+---------------+
> + 3:    < file3 measur. skip > < file1 measur. skip > | 11 | file4 measur. |
> +                                                     +----+---------------+
> +
> + PCR:  Extend               = Extend              != Extend
> +       dlist                  dlist                  dlist, file4
> +
> +
> +The first entry in the measurement list contains the digest of the digest
> +list uploaded to the kernel at kernel initialization time.
> +
> +When a file is accessed, IMA queries DIGLIM with the calculated file digest
> +and, if it is found, IMA skips the measurement.
> +
> +Thus, the only information sent to remote verifiers are: the list of
> +files that could possibly be accessed (from the digest list), but not if
> +they were accessed and when; the measurement of unknown files.
> +
> +Despite providing less information, this solution has the advantage that
> +the good system state (i.e. when only ``file1``, ``file2`` and ``file3``
> +are accessed) now can be represented with a deterministic PCR value (the
> +PCR is extended only with the measurement of the digest list). Also, the
> +bad system state can still be distinguished from the good state (the PCR is
> +extended also with the measurement of ``file4``).
> +
> +If a TPM key is bound to the good PCR value, the TPM would allow the key to
> +be used if ``file1``, ``file2`` or ``file3`` are accessed, regardless of
> +the sequence in which they are accessed (the PCR value does not change),
> +and would revoke the permission when the unknown ``file4`` is accessed (the
> +PCR value changes). If a system is able to establish a TLS connection with
> +a peer, this implicitly means that the system was in a good state (i.e.
> +``file4`` was not accessed, otherwise the TPM would have denied the usage
> +of the TPM key due to the key policy).
> +
> +
> +Benefits for IMA Appraisal
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Extending secure boot to applications means being able to verify the
> +provenance of files accessed. IMA does it by verifying file signatures with
> +a key that it trusts, which requires Linux distribution vendors to
> +additionally include in the package header a signature for each file that
> +must be verified (there is the dedicated ``RPMTAG_FILESIGNATURES`` section
> +in the RPM header).
> +
> +The proposed approach would be instead to verify data provenance from
> +already available metadata (file digests) in existing packages. IMA would
> +verify the signature of package metadata and search file digests extracted
> +from package metadata and added to the hash table in the kernel.
> +
> +For RPMs, file digests can be found in the ``RPMTAG_FILEDIGESTS`` section
> +of ``RPMTAG_IMMUTABLE``, whose signature is in ``RPMTAG_RSAHEADER``. For
> +DEBs, file digests (unsafe to use due to a weak digest algorithm) can be
> +found in the ``md5sum`` file, which can be indirectly verified from
> +``Release.gpg``.
> +
> +The following figure highlights the differences between the current and the
> +proposed approach.
> +
> +::
> +
> + IMA appraisal (current solution, with file signatures):
> +
> +                                                         appraise
> +                                                      +-----------+
> +                                                      V           |
> + +-------------------------+-----+         +-------+-----+        |
> + | RPM header              |     | ima rpm | file1 | sig |        |
> + | ...                     |     | plugin  +-------+-----+     +-----+
> + | file1 sig [to be added] | sig |-------->      ...           | IMA |
> + | ...                     |     |         +-------+-----+     +-----+
> + | fileN sig [to be added] |     |         | fileN | sig |
> + +-------------------------+-----+         +-------+-----+
> +
> +In this case, file signatures must be added to the RPM header, so that the
> +``ima`` rpm plugin can extract them together with the file content. The RPM
> +header signature is not used.
> +
> +::
> +
> + IMA appraisal (with DIGLIM):
> +
> +                                    kernel hash table
> +                                    with RPM header content
> +                                    +---+    +--------------+
> +                                    |   |--->| file1 digest |
> +                                    +---+    +--------------+
> +                                     ...
> +                                    +---+         appraise (file1)
> +                                    |   |  <--------------+
> + +----------------+-----+           +---+                 |
> + | RPM header     |     |             ^                   |
> + | ...            |     | digest_list |                   |
> + | file1 digest   | sig | rpm plugin  |    +-------+   +-----+
> + | ...            |     |-------------+--->| file1 |   | IMA |
> + | fileN digest   |     |                  +-------+   +-----+
> + +----------------+-----+                                 |
> +                     ^                                    |
> +                     +------------------------------------+
> +                             appraise (RPM header)
> +
> +In this case, the RPM header is used as it is, and its signature is used
> +for IMA appraisal. Then, the ``digest_list`` rpm plugin executes the user
> +space parser to parse the RPM header and add the extracted digests to an
> +hash table in the kernel. IMA appraisal of the files in the RPM package
> +consists in searching their digest in the hash table.
> +
> +Other than reusing available information as digest list, another advantage
> +is the lower computational overhead compared to the solution with file
> +signatures (only one signature verification for many files and digest
> +lookup, instead of per file signature verification, see `Preliminary
> +Performance Evaluation`_ for more details).
> +
> +
> +Lifecycle
> +---------
> +
> +The lifecycle of DIGLIM is represented in the following figure:
> +
> +::

You could just use:

	The lifecycle of DIGLIM is represented in the following figure::

> +
> + Vendor premises (release process with modifications):
> +
> + +------------+   +-----------------------+   +------------------------+
> + | 1. build a |   | 2. generate and sign  |   | 3. publish the package |
> + |    package |-->|    a digest list from |-->|    and digest list in  |
> + |            |   |    packaged files     |   |    a repository        |
> + +------------+   +-----------------------+   +------------------------+
> +                                                                 |
> +                                                                 |
> + User premises:                                                  |
> +                                                                 V
> + +---------------------+   +------------------------+   +-----------------+
> + | 6. use digest lists |   | 5. download the digest |   | 4. download and |
> + |    for measurement  |<--|    list and upload to  |<--|    install the  |
> + |    and/or appraisal |   |    the kernel          |   |    package      |
> + +---------------------+   +------------------------+   +-----------------+
> +
> +The figure above represents all the steps when a digest list is
> +generated separately. However, as mentioned in `Contribution`_, in most
> +cases existing packages can be already used as a source for digest lists,
> +limiting the effort for software vendors.
> +
> +If, for example, RPMs are used as a source for digest lists, the figure
> +above becomes:
> +
> +::

Same here.

> +
> + Vendor premises (release process without modifications):
> +
> + +------------+   +------------------------+
> + | 1. build a |   | 2. publish the package |
> + |    package |-->|    in a repository     |---------------------+
> + |            |   |                        |                     |
> + +------------+   +------------------------+                     |
> +                                                                 |
> +                                                                 |
> + User premises:                                                  |
> +                                                                 V
> + +---------------------+   +------------------------+   +-----------------+
> + | 5. use digest lists |   | 4. extract digest list |   | 3. download and |
> + |    for measurement  |<--|    from the package    |<--|    install the  |
> + |    and/or appraisal |   |    and upload to the   |   |    package      |
> + |                     |   |    kernel              |   |                 |
> + +---------------------+   +------------------------+   +-----------------+
> +
> +Step 4 can be performed with the ``digest_list`` rpm plugin and the user
> +space parser, without changes to rpm itself.
> +
> +
> +Security Assumptions
> +--------------------
> +
> +As mentioned in the `Introduction`_, DIGLIM will be primarily used in
> +conjunction with IMA to enforce a mandatory policy on all user space
> +processes, including those owned by root. Even root, in a system with a
> +locked-down kernel, cannot affect the enforcement of the mandatory policy
> +or, if changes are permitted, it cannot do so without being detected.
> +
> +Given that the target of the enforcement are user space processes, DIGLIM
> +cannot be placed in the target, as a Mandatory Access Control (MAC) design
> +is required to have the components responsible to enforce the mandatory
> +policy separated from the target.
> +
> +While locking-down a system and limiting actions with a mandatory policy is
> +generally perceived by users as an obstacle, it has noteworthy benefits for
> +the users themselves.
> +
> +First, it would timely block attempts by malicious software to steal or
> +misuse user assets. Although users could query the package managers to
> +detect them, detection would happen after the fact, or it wouldn't happen
> +at all if the malicious software tampered with package managers. With a
> +mandatory policy enforced by the kernel, users would still be able to
> +decide which software they want to be executed except that, unlike package
> +managers, the kernel is not affected by user space processes or root.
> +
> +Second, it might make systems more easily verifiable from outside, due to
> +the limited actions the system allows. When users connect to a server, not
> +only they would be able to verify the server identity, which is already
> +possible with communication protocols like TLS, but also if the software
> +running on that server can be trusted to handle their sensitive data.
> +
> +
> +Adoption
> +--------
> +
> +A former version of DIGLIM is used in the following OSes:
> +
> +- openEuler 20.09
> +  https://github.com/openeuler-mirror/kernel/tree/openEuler-20.09
> +
> +- openEuler 21.03
> +  https://github.com/openeuler-mirror/kernel/tree/openEuler-21.03
> +
> +Originally, DIGLIM was part of IMA (known as IMA Digest Lists). In this
> +version, it has been redesigned as a standalone module with an API that
> +makes its functionality accessible by IMA and, eventually, other
> +subsystems.
> +
> +User Space Support
> +------------------
> +
> +Digest lists can be generated and managed with ``digest-list-tools``:
> +
> +https://github.com/openeuler-mirror/digest-list-tools
> +
> +It includes two main applications:
> +
> +- ``gen_digest_lists``: generates digest lists from files in the
> +  filesystem or from the RPM database (more digest list sources can be
> +  supported);
> +- ``manage_digest_lists``: converts and uploads digest lists to the
> +  kernel.
> +
> +Integration with rpm is done with the ``digest_list`` plugin:
> +
> +https://gitee.com/src-openeuler/rpm/blob/master/Add-digest-list-plugin.patch
> +
> +This plugin writes the RPM header and its signature to a file, so that the
> +file is ready to be appraised by IMA, and calls the user space parser to
> +convert and upload the digest list to the kernel.
> +
> +
> +Simple Usage Example (Tested with Fedora 33)
> +--------------------------------------------
> +
> +1. Digest list generation (RPM headers and their signature are copied to
> +   the specified directory):
> +
> +.. code-block:: bash
> +
> + # mkdir /etc/digest_lists
> + # gen_digest_lists -t file -f rpm+db -d /etc/digest_lists -o add
> +
> +2. Digest list upload with the user space parser:
> +
> +.. code-block:: bash
> +
> + # manage_digest_lists -p add-digest -d /etc/digest_lists
> +
> +3. First digest list query:
> +
> +.. code-block:: bash
> +
> + # echo sha256-$(sha256sum /bin/cat) > /sys/kernel/security/integrity/diglim/digest_query
> + # cat /sys/kernel/security/integrity/diglim/digest_query
> +   sha256-[...]-0-file_list-rpm-coreutils-8.32-18.fc33.x86_64 (actions: 0): version: 1, algo: sha256, type: 2, modifiers: 1, count: 106, datalen: 3392
> +
> +4. Second digest list query:
> +
> +.. code-block:: bash
> +
> + # echo sha256-$(sha256sum /bin/zip) > /sys/kernel/security/integrity/diglim/digest_query
> + # cat /sys/kernel/security/integrity/diglim/digest_query
> +   sha256-[...]-0-file_list-rpm-zip-3.0-27.fc33.x86_64 (actions: 0): version: 1, algo: sha256, type: 2, modifiers: 1, count: 4, datalen: 128
> +
> +
> +Preliminary Performance Evaluation
> +----------------------------------
> +
> +This section provides an initial estimation of the overhead introduced by
> +DIGLIM. The estimation has been performed on a Fedora 33 virtual machine
> +with 1447 packages installed. The virtual machine has 16 vCPU (host CPU:
> +AMD Ryzen Threadripper PRO 3955WX 16-Cores) and 2G of RAM (host memory:
> +64G). The virtual machine also has a vTPM with libtpms and swtpm as
> +backend.
> +
> +After writing the RPM headers to files, the size of the directory
> +containing them is 36M.
> +
> +After converting the RPM headers to the compact digest list, the size of
> +the data being uploaded to the kernel is 3.6M.
> +
> +The time to load the entire RPM database is 0.628s.
> +
> +After loading the digest lists to the kernel, the slab usage due to
> +indexing is (obtained with slab_nomerge in the kernel command line):
> +
> +::
> +
> + OBJS   ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> + 118144 118144 100%    0,03K    923      128      3692K digest_list_item_ref_cache
> + 102400 102400 100%    0,03K    800      128      3200K digest_item_cache
> +   2646   2646 100%    0,09K     63       42       252K digest_list_item_cache
> +
> +The stats, obtained from the ``digests_count`` interface, introduced later,
> +are:
> +
> +::
> +
> + Parser digests: 0
> + File digests: 99100
> + Metadata digests: 0
> + Digest list digests: 1423
> +
> +On this installation, this would be the worst case in which all files are
> +measured and/or appraised, which is currently not recommended without
> +enforcing an integrity policy protecting mutable files. Infoflow LSM is a
> +component to accomplish this task:
> +
> +https://patchwork.kernel.org/project/linux-integrity/cover/20190818235745.1417-1-roberto.sassu@huawei.com/
> +
> +The first manageable goal of IMA with DIGLIM is to use an execution policy,
> +with measurement and/or appraisal of files executed or mapped in memory as
> +executable (in addition to kernel modules and firmware). In this
> +case, the digest list contains the digest only for those files. The numbers
> +above change as follows.
> +
> +After converting the RPM headers to the compact digest list, the size of
> +the data being uploaded to the kernel is 208K.
> +
> +The time to load the digest of binaries and shared libraries is 0.062s.
> +
> +After loading the digest lists to the kernel, the slab usage due to
> +indexing is:
> +
> +::
> +
> + OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> + 7168   7168 100%    0,03K     56      128       224K digest_list_item_ref_cache
> + 7168   7168 100%    0,03K     56      128       224K digest_item_cache
> + 1134   1134 100%    0,09K     27       42       108K digest_list_item_cache
> +
> +
> +The stats, obtained from the ``digests_count`` interface, are:
> +
> +::
> +
> + Parser digests: 0
> + File digests: 5986
> + Metadata digests: 0
> + Digest list digests: 1104
> +
> +
> +Comparison with IMA
> +~~~~~~~~~~~~~~~~~~~
> +
> +This section compares the performance between the current solution for IMA
> +measurement and appraisal, and IMA with DIGLIM.
> +
> +
> +Workload A (without DIGLIM):
> +
> +#. cat file[0-5985] > /dev/null
> +
> +
> +Workload B (with DIGLIM):
> +
> +#. echo $PWD/0-file_list-compact-file[0-1103] > <securityfs>/integrity/diglim/digest_list_add
> +#. cat file[0-5985] > /dev/null
> +
> +
> +Workload A execution time without IMA policy:
> +
> +::
> +
> + real	0m0,155s
> + user	0m0,008s
> + sys	0m0,066s
> +
> +
> +Measurement
> +...........
> +
> +IMA policy:
> +
> +::
> +
> + measure fowner=2000 func=FILE_CHECK mask=MAY_READ use_diglim=allow pcr=11 ima_template=ima-sig
> +
> +``use_diglim`` is a policy keyword not yet supported by IMA.
> +
> +
> +Workload A execution time with IMA and 5986 files with signature measured:
> +
> +::
> +
> + real	0m8,273s
> + user	0m0,008s
> + sys	0m2,537s
> +
> +
> +Workload B execution time with IMA, 1104 digest lists with signature
> +measured and uploaded to the kernel, and 5986 files with signature accessed
> +but not measured (due to the file digest being found in the hash table):
> +
> +::
> +
> + real	0m1,837s
> + user	0m0,036s
> + sys	0m0,583s
> +
> +
> +Appraisal
> +.........
> +
> +IMA policy:
> +
> +::
> +
> + appraise fowner=2000 func=FILE_CHECK mask=MAY_READ use_diglim=allow
> +
> +``use_diglim`` is a policy keyword not yet supported by IMA.
> +
> +
> +Workload A execution time with IMA and 5986 files with file signature
> +appraised:
> +
> +::
> +
> + real	0m2,197s
> + user	0m0,011s
> + sys	0m2,022s
> +
> +
> +Workload B execution time with IMA, 1104 digest lists with signature
> +appraised and uploaded to the kernel, and with 5986 files with signature
> +not verified (due to the file digest being found in the hash table):
> +
> +::
> +
> + real	0m0,982s
> + user	0m0,020s
> + sys	0m0,865s
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 16335de04e8c..6c3aea41c55b 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -17,3 +17,4 @@ Security Documentation
>     tpm/index
>     digsig
>     landlock
> +   diglim/index
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c8be735cc91..c914dadd7e65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5452,6 +5452,15 @@ L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-gpio-mm.c
>  
> +DIGLIM
> +M:	Roberto Sassu <roberto.sassu@huawei.com>
> +L:	linux-integrity@vger.kernel.org
> +S:	Supported
> +T:	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> +F:	Documentation/security/diglim/architecture.rst
> +F:	Documentation/security/diglim/index.rst
> +F:	Documentation/security/diglim/introduction.rst
> +
>  DIOLAN U2C-12 I2C DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-i2c@vger.kernel.org



Thanks,
Mauro
