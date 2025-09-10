Return-Path: <linux-kselftest+bounces-41185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07351B51E70
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F55440B8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321E29992B;
	Wed, 10 Sep 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zg90C5ZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195828C03E
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523631; cv=none; b=PCHIQPOk5V/mnqXmdbzxh7l8QCbc7EtbTQivEX+Ki9+o8BL6JnD82/xJCPn6fyoATfRoxt+dFFcHh4LmtQ8qww45u9WCtQqfWyXum6Jx2niAX8YQJIplu/9VYchZUo+WWJqaYFILa8AOAmR91IG9yCnyatYDiTmjx3xPZ/wech4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523631; c=relaxed/simple;
	bh=SD5ytb/xU/W1ovRiWGgbNzeHsrA6HUBkcwxbK3JbshE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyNh6FhmeiVzRLLlujTduSg74M8FemhHJghVNkjgkmzXBviu9pDDdB9Yj9HxRpSKq2yGwc8iEMCmdUWyPx/G5mBy7mtVnwmtb2TvWck3JlM8nqsaqdCYy4q+JrI7Hu8dNevHQvEa25gIpDjy+EITh3O9Ef87Vsh8/Y0OPd/PHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zg90C5ZM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757523628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ii1zp41sejenDdX+Fc0ZqaS5dEwSpPRBnvyGP/EInUw=;
	b=Zg90C5ZMqxhCH4P3HnDsoF38bdeGHkTz6HqX5X/zl3IQ+VmuNtqBYVKjrnwgiuuFmWJzc7
	eJTql5SXuCvpkte+iZy5pPjCvXMYlKE5ItANxc0MmEU0pSMpmugxrFi3H0tSAs2D+xz7xX
	e8rwpDlqJ94H611RqsyA40wStJClIRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-CvBpK9KkO1SOHH-ct7Qx8w-1; Wed,
 10 Sep 2025 13:00:23 -0400
X-MC-Unique: CvBpK9KkO1SOHH-ct7Qx8w-1
X-Mimecast-MFC-AGG-ID: CvBpK9KkO1SOHH-ct7Qx8w_1757523621
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3DF9195419F;
	Wed, 10 Sep 2025 17:00:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBB781956095;
	Wed, 10 Sep 2025 17:00:14 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech,
	acarmina@redhat.com,
	kstewart@linuxfoundation.org,
	chuckwolber@gmail.com,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing testable code specifications
Date: Wed, 10 Sep 2025 18:59:58 +0200
Message-ID: <20250910170000.6475-2-gpaoloni@redhat.com>
In-Reply-To: <20250910170000.6475-1-gpaoloni@redhat.com>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The Documentation/doc-guide/kernel-doc.rst chapter describes
how to document the code using the kernel-doc format, however
it does not specify the criteria to be followed for writing
testable specifications; i.e. specifications that can be used
to for the semantic description of low level requirements.

This patch adds a guideline that defines criteria to formally
describe developers’ intent at the function and subfunction
level in the form of testable expectations.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
Signed-off-by: Chuck Wolber <chuckwolber@gmail.com>
Signed-off-by: Kate Stewart <kstewart@linuxfoundation.org>
---
 .../doc-guide/code-specifications.rst         | 208 ++++++++++++++++++
 Documentation/doc-guide/index.rst             |   1 +
 2 files changed, 209 insertions(+)
 create mode 100644 Documentation/doc-guide/code-specifications.rst

diff --git a/Documentation/doc-guide/code-specifications.rst b/Documentation/doc-guide/code-specifications.rst
new file mode 100644
index 000000000000..dee1b4f089e1
--- /dev/null
+++ b/Documentation/doc-guide/code-specifications.rst
@@ -0,0 +1,208 @@
+.. title:: How-to write testable code specifications
+
+=========================================
+How-to write testable code specifications
+=========================================
+
+Introduction
+------------
+The Documentation/doc-guide/kernel-doc.rst chapter describes how to document the code using the kernel-doc format, however it does not specify the criteria to be followed for writing testable specifications; i.e. specifications that can be used to for the semantic description of low level requirements.
+
+This chapter defines criteria to formally describe developers’ intent at the function and subfunction level in the form of testable expectations.
+
+A Virtuous Cycle
+----------------
+By adding testable specifications at the function or (where relevant) subfunction level, one enables the creation of a virtuous cycle when testing is supplemented with open source code coverage tools like llvm-cov or Gcov.
+
+As a true reflection of developer intent, code specifications inform the creation of a pass/fail tests which can then be assessed in conjunction with code coverage tools. A failing test may indicate broken code or specifications that fail to capture developer intent. A gap in code coverage may indicate missing specifications, unintended functionalities, or insufficient test procedure.
+
+High level goals
+----------------
+The code specifications:
+
+1. Should be maintainable together with the code.
+2. Should support hierarchical traceability to allow refinement of SW dependencies (i.e. cross reference critical APIs or data structures).
+3. Should describe error conditions and success behaviors.
+4. Should describe conditions to be met by the user to avoid unspecified or unwanted behaviours.
+5. Should allow covering both static and dynamic aspects of the code.
+6. Should be compatible with Documentation/doc-guide/kernel-doc.rst.
+7. Should support the definition of a test plan (i.e. syntax should enforce testability as well as the avoidance of untestable specifications, e.g “function_xyz() shall not do something”).
+
+Format and Syntax
+-----------------
+Testable code specifications must be written according to the syntax already defined in Documentation/doc-guide/kernel-doc.rst with additional rules that are described below.
+
+Function name
+~~~~~~~~~~~~~
+``* function_name() - Brief description of function.``
+
+This field is to be considered informative and is not part of the testable specifications.
+
+Input Arguments
+~~~~~~~~~~~~~~~
+Input arguments should be specified in a way that better supports the function’s expectations and Assumptions of Use described below.
+They must not contradict the function's expectations and the function’s prototype. For example::
+
+ * trace_set_clr_event - enable or disable an event
+ * @system: system name to match (NULL for any system)
+ * @event: event name to match (NULL for all events, within system)
+ * @set: 1 to enable, 0 to disable
+ *
+ [...]
+ *
+ */
+ int trace_set_clr_event(const char *system, const char *event, int set)
+
+Above all the parameters clearly introduce the impact that they have on the code specifications.
+
+However if below we had::
+
+ * trace_set_clr_event - enable or disable an event
+ * @system: system name to match (NULL for any system)
+ * @event: event name to match (NULL for all events, within system)
+ * @set: true to enable, false to disable \
+ [...]
+ */
+ int trace_set_clr_event(const char *system, const char *event, int set)
+
+In this case @set would be a bad definition since it is defined as an integer and not as a boolean.
+
+Longer Description
+~~~~~~~~~~~~~~~~~~
+The `Longer Description` section is where the large part of testable code specifications are defined. The section must be organised as follows::
+
+ * (Summary Description) provides an introduction of the functionalities
+ * provided by the function and any informal note. This text does not
+ * represent any testable code specification.
+ *
+ *
+ * Function's expectations:
+ * [ID1] - [code expectation]
+ *
+ * [ID2] - [code expectation]
+ *
+ * [...]
+ *
+ * [IDn] - [code expectation]
+ *
+ * Assumptions of Use:
+ * [ID1] - [constraint to be met by the caller]
+ *
+ * [ID2] - [constraint to be met by the caller]
+ *
+ * [IDn] - [constraint to be met by the caller]
+ *
+
+When writing the above section the following rules must be followed:
+
+* No rules apply to the text above ``Function’s expectations``; such a text does not constitute testable specifications and it is just informative;
+* Both ``Function’s expectations`` and ``Assumptions of Use`` must be listed prefixing each of them with an ID that is unique within this kernel-doc header. The reason for this is to facilitate cross-referencing and traceability between tests and code specifications.
+* A Function’s expectation is a testable behavior that the function is expected to comply with (i.e. the function is expected to behave as defined in the function’s expectation).
+* An Assumption of Use is  a pre-condition to be met when invoking the function being documented.
+* Testable functional expectations and Assumptions of Use must be constructed according the same rules that apply when writing software requirements:
+    * Statements should include a subject and a verb, together with other elements necessary to adequately express the information content of the specifications.
+    * The verbs are required to use the following keywords:
+        * For mandatory expectations the verb ‘shall’ is to be used;
+        * For descriptive text that do not constitute a testable expectation verbs such as ‘are’, ‘is’, ‘was’ are to be used;
+        * Negative expectations must be avoided (e.g. ‘shall not’ must be avoided).
+* Statements must be constructed according to the following scheme:
+
+    [**Condition**] [**Subject**] [**Verb/Action**] [**Object**] [**Constraint of Action**].
+
+    In this regard [**Condition**] and [**Constraint of Action**] could be omitted respectively if the [**Action**] being specified must always happen or if there are no constraints associated with it.
+
+Function Context
+~~~~~~~~~~~~~~~~
+The function’s context represents an integral part of Function’s expectations and Assumptions of Use, where these can further specify the information contained in this section.
+
+Without further specifications this section is to be interpreted as per example below:
+
+``* Context: Any context.``
+
+The function shall execute in any possible context.
+
+``* Context: Any context. Takes and releases the RCU lock.``
+
+The function shall execute in any possible context.
+The function shall take and release the RCU lock.
+
+``* Context: Any context. Expects <lock> to be held by caller.``
+
+The function shall execute in any possible context.
+<lock> is assumed to be held before this function is called.
+
+``* Context: Process context. May sleep if @gfp flags permit.``
+
+The function shall execute in process context.
+The function shall sleep according to @gfp flags definitions
+
+``* Context: Process context. Takes and releases <mutex>.``
+
+The function shall execute in process context.
+The function shall take and release <mutex>.
+
+``* Context: Softirq or process context. Takes and releases <lock>, BH-safe.``
+
+The function shall execute in process or Softirq context.
+The function shall take and release <lock>.
+The function shall safely execute in bottom half contexts.
+
+``* Context: Interrupt context.``
+
+The function shall execute in interrupt context only.
+
+It is a good practice to further specify the context specifications as part of the Function’s expectation (e.g. at which stage a lock is held and released)
+
+Return values
+~~~~~~~~~~~~~
+Return values must be written as a multiple line list in the following format::
+
+* Return:
+* * [value-1] - [condition-1]
+* * [value-2] - [condition-2]
+* * [...]
+* * [value-n] - [condition-n]
+* * Any value returned by func-1(), func-2(),...,func-n()
+
+In such a format ``[value-i]`` must be a clearly identified value or range of values that is compatible with the function prototype (e.g. for a read() file operation, it is ok to define [value-i] as ``the number of bytes successfully copied to the user space buffer``).
+
+``[condition-i]`` must be a condition that can be unambiguously traced back to the ``Function’s expectations`` or ``Context`` defined above; as part of [condition-i] it is possible to refer to dependencies of invoked functions or of internal SW or HW states.
+
+``Any value returned by func-1(), func-2(),...,func-n()`` defines a scenario where the current function is directly returning the value of an invoked function dependency.
+
+Semantic aspects of testable specifications
+-------------------------------------------
+From a semantic point of view it is important to document the intended or expected behavior (from a developer or integrator point of view respectively) in consideration of the different design aspects impacting it.
+
+Such behavior shall be described in a way that makes it possible to define test cases unambiguously. \
+To this extent it is important to document design elements impacting the expected behavior and the design elements characterizing the expected behavior (and sometimes these can physically overlap); such design elements shall be limited to the scope of the code being documented, that can range from a single function to multiple ones depending on the complexity of the overall code.
+
+**Possible elements impacting the expected behavior** of the code being documented are:
+
+* Input parameters: parameters passed to the API being documented;
+* state variables: global and static data (variables or pointers);
+* software dependencies: external SW APIs invoked by the code under analysis;
+* Hardware dependencies: HW design elements directly impacting the behavior of the code in scope;
+* Firmware dependencies: FW design elements that have an impact on the behavior of the API being documented (e.g. DTB or ACPI tables, or runtime services like SCMI and ACPI AML);
+* Compile time configuration parameters: configuration parameters parsed when compiling the Kernel Image;
+* Runtime configuration parameters (AKA calibration parameters): parameters that can be modified at runtime.
+
+**Design elements characterizing the expected behavior** of the API being documented that are in scope according to the above mentioned granularity:
+
+* API return values, including pointer addresses;
+* Input pointers: pointers passed as input parameter to the API being documented;
+* state variables: global and static data (variable or pointers);
+* Hardware design elements (e.g. HW registers).
+
+**Testability considerations**: the impact of each of the documented “design elements impacting the expected behavior” must be described in terms of effect on the “design element characterizing the expected behavior” and, in doing so, it is important to document allowed or not allowed ranges of values, corner cases and error conditions;  so that it is possible to define a meaningful test plan according to different equivalence classes.
+
+**Scalability and maintainability considerations**: the described expected behavior must be limited to the scope of the code under analysis so for example the Software, Firmware and Hardware dependencies shall be described in terms of possible impact on the invoking code deferring further details to the respective documentation of these.
+
+When deciding the scope of the code being documented, the scalability and maintainability goals must be considered; it does not make sense to embed the documentation of multiple complex functions within the kernel-doc header of the top level function as, doing so, would make it harder to review the code changes against the documented specifications and/or to extend the specifications to new functionalities being added.
+
+The end goal is to build a hierarchical, scalable, maintainable documentation.
+
+**Feasibility considerations**: Only the “meaningful” and “useful” expected behavior, and the design elements impacting it, shall be considered (e.g. a printk() logging some info may be omitted). There are two reasons behind this point:
+
+1. Specifying the expected behaviour of the code should be done, in principle, in a code agnostic way. So it is not about writing a pseudo-code redundant implementation, but rather about defining and documenting the developer intent and the integrator’s expectations.
+2. When the expected behavior is defined before implementing the code, such an activity is done by experts using a level of detail that is more abstract than the code itself and they only refer to aspects that are relevant for the design expectations.
diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
index 24d058faa75c..09e459866442 100644
--- a/Documentation/doc-guide/index.rst
+++ b/Documentation/doc-guide/index.rst
@@ -9,6 +9,7 @@ How to write kernel documentation
 
    sphinx
    kernel-doc
+   code-specifications
    parse-headers
    contributing
    maintainer-profile
-- 
2.48.1


