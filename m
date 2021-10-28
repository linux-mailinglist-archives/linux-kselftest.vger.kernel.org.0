Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B472A43DD69
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1JK4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 05:10:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4036 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1JKy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 05:10:54 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hg03R3BYZz6H7lF;
        Thu, 28 Oct 2021 17:03:47 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 11:08:25 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.015;
 Thu, 28 Oct 2021 11:08:25 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 00/13] integrity: Introduce DIGLIM
Thread-Topic: [PATCH v3 00/13] integrity: Introduce DIGLIM
Thread-Index: AQHXqYZfx1aG2K6H1Emwo94gVZnbhavoYVog
Date:   Thu, 28 Oct 2021 09:08:25 +0000
Message-ID: <bc9521dd0412471e8e928110d7e0f11a@huawei.com>
References: <20210914163401.864635-1-roberto.sassu@huawei.com>
In-Reply-To: <20210914163401.864635-1-roberto.sassu@huawei.com>
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

> From: Roberto Sassu
> Sent: Tuesday, September 14, 2021 6:34 PM
> Status
> ======
> 
> This version of the patch set implements the suggestions received for
> version 2. Apart from one patch added for the IMA API and few fixes, there
> are no substantial changes. It has been tested on: x86_64, UML (x86_64),
> s390x (big endian).

Hi everyone

I didn't receive comments on this version. I believe it is ready to be
accepted, as I addressed the comments for the previous versions
and the tests I wrote are sufficiently complete to find possible
problems.

Is there anything I could do to increase the chances of acceptance?
Would moving DIGLIM to security/ instead of security/integrity/
make it more suitable for inclusion?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua

> The long term goal is to boot a system with appraisal enabled and with
> DIGLIM as repository for reference values, taken from the RPM database.
> 
> Changes required:
> - new execution policies in IMA
>   (https://lore.kernel.org/linux-integrity/20210409114313.4073-1-
> roberto.sassu@huawei.com/)
> - support for the euid policy keyword for critical data
>   (https://lore.kernel.org/linux-integrity/20210705115650.3373599-1-
> roberto.sassu@huawei.com/)
> - basic DIGLIM
>   (this patch set)
> - additional DIGLIM features (loader, LSM, user space utilities)
> - support for DIGLIM in IMA
> - support for PGP keys and signatures
>   (from David Howells)
> - support for PGP appended signatures in IMA
> 
> 
> Introduction
> ============
> 
> Digest Lists Integrity Module (DIGLIM) is a component of the integrity
> subsystem in the kernel, primarily aiming to aid Integrity Measurement
> Architecture (IMA) in the process of checking the integrity of file
> content and metadata. It accomplishes this task by storing reference
> values coming from software vendors and by reporting whether or not the
> digest of file content or metadata calculated by IMA (or EVM) is found
> among those values. In this way, IMA can decide, depending on the result
> of a query, if a measurement should be taken or access to the file
> should be granted. The Security Assumptions section explains more in
> detail why this component has been placed in the kernel.
> 
> The main benefits of using IMA in conjunction with DIGLIM are the
> ability to implement advanced remote attestation schemes based on the
> usage of a TPM key for establishing a TLS secure channel[1][2], and to
> reduce the burden on Linux distribution vendors to extend secure boot at
> OS level to applications.
> 
> DIGLIM does not have the complexity of feature-rich databases. In fact,
> its main functionality comes from the hash table primitives already in
> the kernel. It does not have an ad-hoc storage module, it just indexes
> data in a fixed format (digest lists, a set of concatenated digests
> preceded by a header), copied to kernel memory as they are. Lastly, it
> does not support database-oriented languages such as SQL, but only
> accepts a digest and its algorithm as a query.
> 
> The only digest list format supported by DIGLIM is called compact.
> However, Linux distribution vendors don't have to generate new digest
> lists in this format for the packages they release, as already available
> information, such as RPM headers and DEB package metadata, can be used
> as a source for reference values (they include file digests), with a
> user space parser taking care of the conversion to the compact format.
> 
> Although one might perceive that storing file or metadata digests for a
> Linux distribution would significantly increase the memory usage, this
> does not seem to be the case. As an anticipation of the evaluation done
> in the Preliminary Performance Evaluation section, protecting binaries
> and shared libraries of a minimal Fedora 33 installation requires 208K
> of memory for the digest lists plus 556K for indexing.
> 
> In exchange for a slightly increased memory usage, DIGLIM improves the
> performance of the integrity subsystem. In the considered scenario, IMA
> measurement and appraisal of 5896 files with digest lists requires
> respectively less than one quarter and less than half the time, compared
> to the current solution.
> 
> DIGLIM also keeps track of whether digest lists have been processed in
> some way (e.g. measured or appraised by IMA). This is important for
> example for remote attestation, so that remote verifiers understand what
> has been uploaded to the kernel.
> 
> Operations in DIGLIM are atomic: if an error occurs during the addition
> of a digest list, DIGLIM rolls back the entire insert operation;
> deletions instead always succeed. This capability has been tested with
> an ad-hoc fault injection mechanism capable of simulating failures
> during the operations.
> 
> Finally, DIGLIM exposes to user space, through securityfs, the digest
> lists currently loaded, the number of digests added, a query interface
> and an interface to set digest list labels.
> 
> 
> Binary Integrity
> 
> Integrity is a fundamental security property in information systems.
> Integrity could be described as the condition in which a generic
> component is just after it has been released by the entity that created
> it.
> 
> One way to check whether a component is in this condition (called binary
> integrity) is to calculate its digest and to compare it with a reference
> value (i.e. the digest calculated in controlled conditions, when the
> component is released).
> 
> IMA, a software part of the integrity subsystem, can perform such
> evaluation and execute different actions:
> 
> -   store the digest in an integrity-protected measurement list, so that
>     it can be sent to a remote verifier for analysis;
> -   compare the calculated digest with a reference value (usually
>     protected with a signature) and deny operations if the file is found
>     corrupted;
> -   store the digest in the system log.
> 
> 
> Benefits
> 
> DIGLIM further enhances the capabilities offered by IMA-based solutions
> and, at the same time, makes them more practical to adopt by reusing
> existing sources as reference values for integrity decisions.
> 
> Possible sources for digest lists are:
> 
> -   RPM headers;
> -   Debian repository metadata.
> 
> Benefits for IMA Measurement
> 
> One of the issues that arises when files are measured by the OS is that,
> due to parallel execution, the order in which file accesses happen
> cannot be predicted. Since the TPM Platform Configuration Register (PCR)
> extend operation, executed after each file measurement,
> cryptographically binds the current measurement to the previous ones,
> the PCR value at the end of a workload cannot be predicted too.
> 
> Thus, even if the usage of a TPM key, bound to a PCR value, should be
> allowed when only good files were accessed, the TPM could unexpectedly
> deny an operation on that key if files accesses did not happen as stated
> by the key policy (which allows only one of the possible sequences).
> 
> DIGLIM solves this issue by making the PCR value stable over the time
> and not dependent on file accesses. The following figure depicts the
> current and the new approaches:
> 
>     IMA measurement list (current)
> 
>     entry#        1st boot               2nd boot               3rd boot
>           +----+---------------+ +----+---------------+ +----+---------------+
>     1:    | 10 | file1 measur. | | 10 | file3 measur. | | 10 | file2 measur. |
>           +----+---------------+ +----+---------------+ +----+---------------+
>     2:    | 10 | file2 measur. | | 10 | file2 measur. | | 10 | file3 measur. |
>           +----+---------------+ +----+---------------+ +----+---------------+
>     3:    | 10 | file3 measur. | | 10 | file1 measur. | | 10 | file4 measur. |
>           +----+---------------+ +----+---------------+ +----+---------------+
> 
>     PCR:  Extend              != Extend              != Extend
>           file1, file2, file3    file3, file2, file1    file2, file3, file4
> 
> 
>     PCR Extend definition:
> 
>           PCR(new value) = Hash(Hash(meas. entry), PCR(previous value))
> 
> A new entry in the measurement list is created by IMA for each file
> access. Assuming that file1, file2 and file3 are files provided by the
> software vendor, file4 is an unknown file, the first two PCR values
> above represent a good system state, the third a bad system state. The
> PCR values are the result of the PCR extend operation performed for each
> measurement entry with the digest of the measurement entry as an input.
> 
>     IMA measurement list (with DIGLIM)
> 
>     dlist
>     +--------------+
>     |    header    |
>     +--------------+
>     | file1 digest |
>     | file2 digest |
>     | file3 digest |
>     +--------------+
> 
> dlist is a digest list containing the digest of file1, file2 and file3.
> In the intended scenario, it is generated by a software vendor at the
> end of the building process, and retrieved by the administrator of the
> system where the digest list is loaded.
> 
>     entry#        1st boot               2nd boot               3rd boot
>           +----+---------------+ +----+---------------+ +----+---------------+
>     0:    | 11 | dlist measur. | | 11 | dlist measur. | | 11 | dlist measur. |
>           +----+---------------+ +----+---------------+ +----+---------------+
>     1:    < file1 measur. skip > < file3 measur. skip > < file2 measur. skip >
> 
>     2:    < file2 measur. skip > < file2 measur. skip > < file3 measur. skip >
>                                                         +----+---------------+
>     3:    < file3 measur. skip > < file1 measur. skip > | 11 | file4 measur. |
>                                                         +----+---------------+
> 
>     PCR:  Extend               = Extend              != Extend
>           dlist                  dlist                  dlist, file4
> 
> The first entry in the measurement list contains the digest of the
> digest list uploaded to the kernel at kernel initialization time.
> 
> When a file is accessed, IMA queries DIGLIM with the calculated file
> digest and, if it is found, IMA skips the measurement.
> 
> Thus, the only information sent to remote verifiers are: the list of
> files that could possibly be accessed (from the digest list), but not if
> they were accessed and when; the measurement of unknown files.
> 
> Despite providing less information, this solution has the advantage that
> the good system state (i.e. when only file1, file2 and file3 are
> accessed) now can be represented with a deterministic PCR value (the PCR
> is extended only with the measurement of the digest list). Also, the bad
> system state can still be distinguished from the good state (the PCR is
> extended also with the measurement of file4).
> 
> If a TPM key is bound to the good PCR value, the TPM would allow the key
> to be used if file1, file2 or file3 are accessed, regardless of the
> sequence in which they are accessed (the PCR value does not change), and
> would revoke the permission when the unknown file4 is accessed (the PCR
> value changes). If a system is able to establish a TLS connection with a
> peer, this implicitly means that the system was in a good state (i.e.
> file4 was not accessed, otherwise the TPM would have denied the usage of
> the TPM key due to the key policy).
> 
> Benefits for IMA Appraisal
> 
> Extending secure boot to applications means being able to verify the
> provenance of files accessed. IMA does it by verifying file signatures
> with a key that it trusts, which requires Linux distribution vendors to
> additionally include in the package header a signature for each file
> that must be verified (there is the dedicated RPMTAG_FILESIGNATURES
> section in the RPM header).
> 
> The proposed approach would be instead to verify data provenance from
> already available metadata (file digests) in existing packages. IMA
> would verify the signature of package metadata and search file digests
> extracted from package metadata and added to the hash table in the
> kernel.
> 
> For RPMs, file digests can be found in the RPMTAG_FILEDIGESTS section of
> RPMTAG_IMMUTABLE, whose signature is in RPMTAG_RSAHEADER. For DEBs,
> file
> digests (unsafe to use due to a weak digest algorithm) can be found in
> the md5sum file, which can be indirectly verified from Release.gpg.
> 
> The following figure highlights the differences between the current and
> the proposed approach.
> 
>     IMA appraisal (current solution, with file signatures):
> 
>                                                             appraise
>                                                          +-----------+
>                                                          V           |
>     +-------------------------+-----+         +-------+-----+        |
>     | RPM header              |     | ima rpm | file1 | sig |        |
>     | ...                     |     | plugin  +-------+-----+     +-----+
>     | file1 sig [to be added] | sig |-------->      ...           | IMA |
>     | ...                     |     |         +-------+-----+     +-----+
>     | fileN sig [to be added] |     |         | fileN | sig |
>     +-------------------------+-----+         +-------+-----+
> 
> In this case, file signatures must be added to the RPM header, so that
> the ima rpm plugin can extract them together with the file content. The
> RPM header signature is not used.
> 
>     IMA appraisal (with DIGLIM):
> 
>                                        kernel hash table
>                                        with RPM header content
>                                        +---+    +--------------+
>                                        |   |--->| file1 digest |
>                                        +---+    +--------------+
>                                         ...
>                                        +---+         appraise (file1)
>                                        |   |  <--------------+
>     +----------------+-----+           +---+                 |
>     | RPM header     |     |             ^                   |
>     | ...            |     | digest_list |                   |
>     | file1 digest   | sig | rpm plugin  |    +-------+   +-----+
>     | ...            |     |-------------+--->| file1 |   | IMA |
>     | fileN digest   |     |                  +-------+   +-----+
>     +----------------+-----+                                 |
>                         ^                                    |
>                         +------------------------------------+
>                                 appraise (RPM header)
> 
> In this case, the RPM header is used as it is, and its signature is used
> for IMA appraisal. Then, the digest_list rpm plugin executes the user
> space parser to parse the RPM header and add the extracted digests to an
> hash table in the kernel. IMA appraisal of the files in the RPM package
> consists in searching their digest in the hash table.
> 
> Other than reusing available information as digest list, another
> advantage is the lower computational overhead compared to the solution
> with file signatures (only one signature verification for many files and
> digest lookup, instead of per file signature verification, see
> Preliminary Performance Evaluation for more details).
> 
> 
> Lifecycle
> 
> The lifecycle of DIGLIM is represented in the following figure:
> 
>     Vendor premises (release process with modifications):
> 
>     +------------+   +-----------------------+   +------------------------+
>     | 1. build a |   | 2. generate and sign  |   | 3. publish the package |
>     |    package |-->|    a digest list from |-->|    and digest list in  |
>     |            |   |    packaged files     |   |    a repository        |
>     +------------+   +-----------------------+   +------------------------+
>                                                                     |
>                                                                     |
>     User premises:                                                  |
>                                                                     V
>     +---------------------+   +------------------------+   +-----------------+
>     | 6. use digest lists |   | 5. download the digest |   | 4. download and |
>     |    for measurement  |<--|    list and upload to  |<--|    install the  |
>     |    and/or appraisal |   |    the kernel          |   |    package      |
>     +---------------------+   +------------------------+   +-----------------+
> 
> The figure above represents all the steps when a digest list is
> generated separately. However, as mentioned in Benefits, in most cases
> existing packages can be already used as a source for digest lists,
> limiting the effort for software vendors.
> 
> If, for example, RPMs are used as a source for digest lists, the figure
> above becomes:
> 
>     Vendor premises (release process without modifications):
> 
>     +------------+   +------------------------+
>     | 1. build a |   | 2. publish the package |
>     |    package |-->|    in a repository     |---------------------+
>     |            |   |                        |                     |
>     +------------+   +------------------------+                     |
>                                                                     |
>                                                                     |
>     User premises:                                                  |
>                                                                     V
>     +---------------------+   +------------------------+   +-----------------+
>     | 5. use digest lists |   | 4. extract digest list |   | 3. download and |
>     |    for measurement  |<--|    from the package    |<--|    install the  |
>     |    and/or appraisal |   |    and upload to the   |   |    package      |
>     |                     |   |    kernel              |   |                 |
>     +---------------------+   +------------------------+   +-----------------+
> 
> Step 4 can be performed with the digest_list rpm plugin and the user
> space parser, without changes to rpm itself.
> 
> 
> Security Assumptions
> 
> As mentioned in the Introduction, DIGLIM will be primarily used in
> conjunction with IMA to enforce a mandatory policy on all user space
> processes, including those owned by root. Even root, in a system with a
> locked-down kernel, cannot affect the enforcement of the mandatory
> policy or, if changes are permitted, it cannot do so without being
> detected.
> 
> Given that the target of the enforcement are user space processes,
> DIGLIM cannot be placed in the target, as a Mandatory Access Control
> (MAC) design is required to have the components responsible to enforce
> the mandatory policy separated from the target.
> 
> While locking-down a system and limiting actions with a mandatory policy
> is generally perceived by users as an obstacle, it has noteworthy
> benefits for the users themselves.
> 
> First, it would timely block attempts by malicious software to steal or
> misuse user assets. Although users could query the package managers to
> detect them, detection would happen after the fact, or it wouldn't
> happen at all if the malicious software tampered with package managers.
> With a mandatory policy enforced by the kernel, users would still be
> able to decide which software they want to be executed except that,
> unlike package managers, the kernel is not affected by user space
> processes or root.
> 
> Second, it might make systems more easily verifiable from outside, due
> to the limited actions the system allows. When users connect to a
> server, not only they would be able to verify the server identity, which
> is already possible with communication protocols like TLS, but also if
> the software running on that server can be trusted to handle their
> sensitive data.
> 
> 
> Adoption
> 
> A former version of DIGLIM is used in the following OSes:
> 
> -   openEuler 20.09
>     https://github.com/openeuler-mirror/kernel/tree/openEuler-20.09
> -   openEuler 21.03
>     https://github.com/openeuler-mirror/kernel/tree/openEuler-21.03
> 
> Originally, DIGLIM was part of IMA (known as IMA Digest Lists). In this
> version, it has been redesigned as a standalone module with an API that
> makes its functionality accessible by IMA and, eventually, other
> subsystems.
> 
> 
> User Space Support
> 
> Digest lists can be generated and managed with digest-list-tools:
> 
> https://github.com/openeuler-mirror/digest-list-tools
> 
> It includes two main applications:
> 
> -   gen_digest_lists: generates digest lists from files in the
>     filesystem or from the RPM database (more digest list sources can be
>     supported);
> -   manage_digest_lists: converts and uploads digest lists to the
>     kernel.
> 
> Integration with rpm is done with the digest_list plugin:
> 
> https://gitee.com/src-openeuler/rpm/blob/master/Add-digest-list-plugin.patch
> 
> This plugin writes the RPM header and its signature to a file, so that
> the file is ready to be appraised by IMA, and calls the user space
> parser to convert and upload the digest list to the kernel.
> 
> 
> Simple Usage Example (Tested with Fedora 33)
> 
> 1.  Digest list generation (RPM headers and their signature are copied
>     to the specified directory):
> 
>     # mkdir /etc/digest_lists
>     # gen_digest_lists -t file -f rpm+db -d /etc/digest_lists -o add
> 
> 2.  Digest list upload with the user space parser:
> 
>     # manage_digest_lists -p add-digest -d /etc/digest_lists
> 
> 3.  First digest list query:
> 
>     # echo sha256-$(sha256sum /bin/cat) >
> /sys/kernel/security/integrity/diglim/digest_query
>     # cat /sys/kernel/security/integrity/diglim/digest_query
>       sha256-[...]-0-file_list-rpm-coreutils-8.32-18.fc33.x86_64 (actions: 0):
> version: 1, algo: sha256, type: 2, modifiers: 1, count: 106, datalen: 3392
> 
> 4.  Second digest list query:
> 
>     # echo sha256-$(sha256sum /bin/zip) >
> /sys/kernel/security/integrity/diglim/digest_query
>     # cat /sys/kernel/security/integrity/diglim/digest_query
>       sha256-[...]-0-file_list-rpm-zip-3.0-27.fc33.x86_64 (actions: 0): version: 1,
> algo: sha256, type: 2, modifiers: 1, count: 4, datalen: 128
> 
> 
> Preliminary Performance Evaluation
> 
> This section provides an initial estimation of the overhead introduced
> by DIGLIM. The estimation has been performed on a Fedora 33 virtual
> machine with 1447 packages installed. The virtual machine has 16 vCPU
> (host CPU: AMD Ryzen Threadripper PRO 3955WX 16-Cores) and 2G of RAM
> (host memory: 64G). The virtual machine also has a vTPM with libtpms and
> swtpm as backend.
> 
> After writing the RPM headers to files, the size of the directory
> containing them is 36M.
> 
> After converting the RPM headers to the compact digest list, the size of
> the data being uploaded to the kernel is 3.6M.
> 
> The time to load the entire RPM database is 0.628s.
> 
> After loading the digest lists to the kernel, the slab usage due to
> indexing is (obtained with slab_nomerge in the kernel command line):
> 
>     OBJS   ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>     118144 118144 100%    0,03K    923      128      3692K
> digest_list_item_ref_cache
>     102400 102400 100%    0,03K    800      128      3200K digest_item_cache
>       2646   2646 100%    0,09K     63       42       252K digest_list_item_cache
> 
> The stats, obtained from the digests_count interface, introduced later,
> are:
> 
>     Parser digests: 0
>     File digests: 99100
>     Metadata digests: 0
>     Digest list digests: 1423
> 
> On this installation, this would be the worst case in which all files
> are measured and/or appraised, which is currently not recommended
> without enforcing an integrity policy protecting mutable files. Infoflow
> LSM is a component to accomplish this task:
> 
> https://patchwork.kernel.org/project/linux-
> integrity/cover/20190818235745.1417-1-roberto.sassu@huawei.com/
> 
> The first manageable goal of IMA with DIGLIM is to use an execution
> policy, with measurement and/or appraisal of files executed or mapped in
> memory as executable (in addition to kernel modules and firmware). In
> this case, the digest list contains the digest only for those files. The
> numbers above change as follows.
> 
> After converting the RPM headers to the compact digest list, the size of
> the data being uploaded to the kernel is 208K.
> 
> The time to load the digest of binaries and shared libraries is 0.062s.
> 
> After loading the digest lists to the kernel, the slab usage due to
> indexing is:
> 
>     OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>     7168   7168 100%    0,03K     56      128       224K digest_list_item_ref_cache
>     7168   7168 100%    0,03K     56      128       224K digest_item_cache
>     1134   1134 100%    0,09K     27       42       108K digest_list_item_cache
> 
> The stats, obtained from the digests_count interface, are:
> 
>     Parser digests: 0
>     File digests: 5986
>     Metadata digests: 0
>     Digest list digests: 1104
> 
> Comparison with IMA
> 
> This section compares the performance between the current solution for
> IMA measurement and appraisal, and IMA with DIGLIM.
> 
> Workload A (without DIGLIM):
> 
> 1.  cat file[0-5985] > /dev/null
> 
> Workload B (with DIGLIM):
> 
> 1.  echo $PWD/0-file_list-compact-file[0-1103] >
>     <securityfs>/integrity/diglim/digest_list_add
> 2.  cat file[0-5985] > /dev/null
> 
> Workload A execution time without IMA policy:
> 
>     real   0m0,155s
>     user   0m0,008s
>     sys    0m0,066s
> 
> Measurement
> 
> IMA policy:
> 
>     measure fowner=2000 func=FILE_CHECK mask=MAY_READ use_diglim=allow
> pcr=11 ima_template=ima-sig
> 
> use_diglim is a policy keyword not yet supported by IMA.
> 
> Workload A execution time with IMA and 5986 files with signature
> measured:
> 
>     real   0m8,273s
>     user   0m0,008s
>     sys    0m2,537s
> 
> Workload B execution time with IMA, 1104 digest lists with signature
> measured and uploaded to the kernel, and 5986 files with signature
> accessed but not measured (due to the file digest being found in the
> hash table):
> 
>     real   0m1,837s
>     user   0m0,036s
>     sys    0m0,583s
> 
> Appraisal
> 
> IMA policy:
> 
>     appraise fowner=2000 func=FILE_CHECK mask=MAY_READ use_diglim=allow
> 
> use_diglim is a policy keyword not yet supported by IMA.
> 
> Workload A execution time with IMA and 5986 files with file signature
> appraised:
> 
>     real   0m2,197s
>     user   0m0,011s
>     sys    0m2,022s
> 
> Workload B execution time with IMA, 1104 digest lists with signature
> appraised and uploaded to the kernel, and with 5986 files with signature
> not verified (due to the file digest being found in the hash table):
> 
>     real   0m0,982s
>     user   0m0,020s
>     sys    0m0,865s
> 
> [1] LSS EU 2019 slides and video
> 
> [2] FutureTPM EU project, final review meeting demo slides and video
> 
> v2:
> - fix documentation content and style issues (suggested by Mauro)
> - fix basic definitions description and ensure that the _reserved field of
>   compact list headers is zero (suggested by Greg KH)
> - document the static inline functions to access compact list data
>   (suggested by Mauro)
> - rename htable global variable to diglim_htable (suggested by Mauro)
> - add IMA API to retrieve integrity information about a file or buffer
> - display the digest list in the original format (same endianness as when
>   it was uploaded)
> - support digest lists with appended signature (for IMA appraisal)
> - fix bugs in the tests
> - allocate the digest list label in digest_list_add()
> - rename digest_label interface to digest_list_label
> - check input for digest_query and digest_list_label interfaces
> - don't remove entries in digest_lists_loaded if the same digest list is
>   uploaded again to the kernel
> - deny write access to the digest lists while IMA actions are retrieved
> - add new test digest_list_add_del_test_file_upload_measured_chown
> - remove unused COMPACT_KEY type
> 
> v1:
> - remove 'ima: Add digest, algo, measured parameters to
>   ima_measure_critical_data()', replaced by:
>   https://lore.kernel.org/linux-integrity/20210705090922.3321178-1-
> roberto.sassu@huawei.com/
> - add 'Lifecycle' subsection to better clarify how digest lists are
>   generated and used (suggested by Greg KH)
> - remove 'Possible Usages' subsection and add 'Benefits for IMA
>   Measurement' and 'Benefits for IMA Appraisal' subsubsections
> - add 'Preliminary Performance Evaluation' subsection
> - declare digest_offset and hdr_offset in the digest_list_item_ref
>   structure as u32 (sufficient for digest lists of 4G) to make room for a
>   list_head structure (digest_list_item_ref size: 32)
> - implement digest list reference management with a linked list instead of
>   an array
> - reorder structure members for better alignment (suggested by Mauro)
> - rename digest_lookup() to __digest_lookup() (suggested by Mauro)
> - introduce an object cache for each defined structure
> - replace atomic_long_t with unsigned long in h_table structure definition
>   (suggested by Greg KH)
> - remove GPL2 license text and file names (suggested by Greg KH)
> - ensure that the _reserved field of compact_list_hdr is equal to zero
>   (suggested by Greg KH)
> - dynamically allocate the buffer in digest_lists_show_htable_len() to
>   avoid frame size warning (reported by kernel test robot, dynamic
>   allocation suggested by Mauro)
> - split documentation in multiple files and reference the source code
>   (suggested by Mauro)
> - use #ifdef in include/linux/diglim.h
> - improve generation of event name for IMA measurements
> - add new patch to introduce the 'Remote Attestation' section in the
>   documentation
> - fix assignment of actions variable in digest_list_read() and
>   digest_list_write()
> - always release dentry reference when digest_list_get_secfs_files() is
>   called
> - rewrite add/del and query interfaces to take advantage of m->private
> - prevent deletion of a digest list only if there are actions done at
>   addition time that are not currently being performed
> - fix doc warnings (replace Returns with Return:)
> - perform queries of digest list digests in the existing tests
> - add new tests: digest_list_add_del_test_file_upload_measured,
>   digest_list_check_measurement_list_test_file_upload and
>   digest_list_check_measurement_list_test_buffer_upload
> - don't return a value from digest_del(), digest_list_ref_del, and
>   digest_list_del()
> - improve Makefile for tests
> 
> Roberto Sassu (13):
>   diglim: Overview
>   diglim: Basic definitions
>   diglim: Objects
>   diglim: Methods
>   diglim: Parser
>   diglim: IMA info
>   diglim: Interfaces - digest_list_add, digest_list_del
>   diglim: Interfaces - digest_lists_loaded
>   diglim: Interfaces - digest_list_label
>   diglim: Interfaces - digest_query
>   diglim: Interfaces - digests_count
>   diglim: Remote Attestation
>   diglim: Tests
> 
>  .../security/diglim/architecture.rst          |   46 +
>  .../security/diglim/implementation.rst        |  228 +++
>  Documentation/security/diglim/index.rst       |   14 +
>  .../security/diglim/introduction.rst          |  599 +++++++
>  .../security/diglim/remote_attestation.rst    |   87 +
>  Documentation/security/diglim/tests.rst       |   70 +
>  Documentation/security/index.rst              |    1 +
>  MAINTAINERS                                   |   20 +
>  include/linux/diglim.h                        |   28 +
>  include/linux/kernel_read_file.h              |    1 +
>  include/uapi/linux/diglim.h                   |   51 +
>  security/integrity/Kconfig                    |    1 +
>  security/integrity/Makefile                   |    1 +
>  security/integrity/diglim/Kconfig             |   11 +
>  security/integrity/diglim/Makefile            |    8 +
>  security/integrity/diglim/diglim.h            |  232 +++
>  security/integrity/diglim/fs.c                |  865 ++++++++++
>  security/integrity/diglim/ima.c               |  122 ++
>  security/integrity/diglim/methods.c           |  513 ++++++
>  security/integrity/diglim/parser.c            |  274 ++++
>  security/integrity/integrity.h                |    4 +
>  tools/testing/selftests/Makefile              |    1 +
>  tools/testing/selftests/diglim/Makefile       |   19 +
>  tools/testing/selftests/diglim/common.c       |  135 ++
>  tools/testing/selftests/diglim/common.h       |   32 +
>  tools/testing/selftests/diglim/config         |    3 +
>  tools/testing/selftests/diglim/selftest.c     | 1442 +++++++++++++++++
>  27 files changed, 4808 insertions(+)
>  create mode 100644 Documentation/security/diglim/architecture.rst
>  create mode 100644 Documentation/security/diglim/implementation.rst
>  create mode 100644 Documentation/security/diglim/index.rst
>  create mode 100644 Documentation/security/diglim/introduction.rst
>  create mode 100644 Documentation/security/diglim/remote_attestation.rst
>  create mode 100644 Documentation/security/diglim/tests.rst
>  create mode 100644 include/linux/diglim.h
>  create mode 100644 include/uapi/linux/diglim.h
>  create mode 100644 security/integrity/diglim/Kconfig
>  create mode 100644 security/integrity/diglim/Makefile
>  create mode 100644 security/integrity/diglim/diglim.h
>  create mode 100644 security/integrity/diglim/fs.c
>  create mode 100644 security/integrity/diglim/ima.c
>  create mode 100644 security/integrity/diglim/methods.c
>  create mode 100644 security/integrity/diglim/parser.c
>  create mode 100644 tools/testing/selftests/diglim/Makefile
>  create mode 100644 tools/testing/selftests/diglim/common.c
>  create mode 100644 tools/testing/selftests/diglim/common.h
>  create mode 100644 tools/testing/selftests/diglim/config
>  create mode 100644 tools/testing/selftests/diglim/selftest.c
> 
> --
> 2.25.1

