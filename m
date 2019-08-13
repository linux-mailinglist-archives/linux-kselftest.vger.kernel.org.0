Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453D68AF7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfHMGL5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfHMGL4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68wdd022017;
        Tue, 13 Aug 2019 06:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Ps8fgodfDdVfzRX6A/PCjAl5PtBQ0lTzWUwwAkpC9kM=;
 b=F6qA0XyOvx3AWMxyBWPDs6X6gsL0Ix6YNbPl4qVTJN41Bx935sBbowiWBAhJHDjzlVcK
 F4O+KMvv2lmMf7xgplwbFTE/VKy/uEJ7Mgw2uwEWMxlI7PQUXQ0U8dpvI16AXQcMVYeG
 +PU4MP79BO3xHxFvX9P0Jq+ntlTsYSVLivpNHbMFkd4XadrNe7EMk+VoNMe0YB9m1onF
 iJR1yxhWnUSjVNz0iN4tUNirC/9fbqWFo9Gl2Cf21D7/qQsk1odDC6M1VSq4/XYXF4r+
 DYSy17YZSG6815gyXDvW1ByRsScdV54Mu14eLRMduauLk3nqkRzMhSD3ozJ6PEb48UWB Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Ps8fgodfDdVfzRX6A/PCjAl5PtBQ0lTzWUwwAkpC9kM=;
 b=dasek7rrYKRTtRucf7GO4y4fFvxZuw2/hCOntkkiJJ1KB96ZhQV5tS18prv+C2kShz8B
 91tzWWqDtPjzAIG2pHxxVFIDTQndpcwmvzpHUDydFmCpQIfHtFFHCw9Bgj7c/neB67W2
 QGObyhs9faT5HHlSV57RoJfxg9OA+uZamv/5G1eROvLmUNIeaKvusBtIQVMV0BTkK9Zz
 5/jY3NYee2IXSf2p2HZNUKl+b1pFY0cw3Pyw5J4iXkcjGhexm9/niq6mZ0vQTdIv1AcO
 rfp2pZcqYVHdo1xwpdHIX5irjms5PT0/BxkztclPBue0De8uLSMN5pSSI1SS9/bx4Pwh 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u9pjqbvku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68Phv056320;
        Tue, 13 Aug 2019 06:11:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u9n9hs2rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:30 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6BTx5013533;
        Tue, 13 Aug 2019 06:11:29 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:28 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 10/19] ktf: Add documentation for Kernel Test Framework (KTF)
Date:   Tue, 13 Aug 2019 08:09:25 +0200
Message-Id: <2c37526d9d5378d92819ab620b41140edeccaa1c.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 Documentation/dev-tools/ktf/concepts.rst       | 242 ++++++++++++++-
 Documentation/dev-tools/ktf/debugging.rst      | 248 +++++++++++++++-
 Documentation/dev-tools/ktf/examples.rst       |  26 ++-
 Documentation/dev-tools/ktf/features.rst       | 307 ++++++++++++++++++-
 Documentation/dev-tools/ktf/implementation.rst |  70 ++++-
 Documentation/dev-tools/ktf/index.rst          |  14 +-
 Documentation/dev-tools/ktf/installation.rst   |  73 ++++-
 Documentation/dev-tools/ktf/introduction.rst   | 134 ++++++++-
 Documentation/dev-tools/ktf/progref.rst        | 144 ++++++++-
 9 files changed, 1258 insertions(+)
 create mode 100644 Documentation/dev-tools/ktf/concepts.rst
 create mode 100644 Documentation/dev-tools/ktf/debugging.rst
 create mode 100644 Documentation/dev-tools/ktf/examples.rst
 create mode 100644 Documentation/dev-tools/ktf/features.rst
 create mode 100644 Documentation/dev-tools/ktf/implementation.rst
 create mode 100644 Documentation/dev-tools/ktf/index.rst
 create mode 100644 Documentation/dev-tools/ktf/installation.rst
 create mode 100644 Documentation/dev-tools/ktf/introduction.rst
 create mode 100644 Documentation/dev-tools/ktf/progref.rst

diff --git a/Documentation/dev-tools/ktf/concepts.rst b/Documentation/dev-tools/ktf/concepts.rst
new file mode 100644
index 0000000..9b9ef1a
--- /dev/null
+++ b/Documentation/dev-tools/ktf/concepts.rst
@@ -0,0 +1,242 @@
+
+5. KTF Basic Concepts
+---------------------
+
+Tests and test suites
+*********************
+
+The simplest form of test is to just specify::
+
+	TEST(suite_name, test_name)
+	{
+		<test code and assertions go here>
+	}
+
+A KTF test is declared with TEST() or TEST_F(), which both
+takes both a test suite name and a test name, which are two different
+name spaces. Consequently, each test belongs to one test suite, and
+the test suites are created based on what tests that exists.
+A test suite is just a container of tests which in user space
+contributes to the extended name of a test. Test names must be
+unique within a suite, and test names must also be unique within a
+source file, since the test name is the only parameter needed
+when adding a test.
+
+All tests must be added using ADD_TEST or ADD_LOOP_TEST to be visible
+to KTF's runtime framework. This allows tests to be declared while
+under development, but not added (or the ADD_TEST could be commented
+out) if the test or the kernel module under test is not ready
+yet for some reason.
+
+Test fixtures
+*************
+
+As in other unit test frameworks, a test fixture is a mechanism to
+allow several tests to run under the same conditions, in that setup
+and teardown is done before and after each test. In KTF a test fixture
+must first be declared with DECLARE_F() which takes a fixture name
+followed by a list of attributes and an end brace, and initialized
+with INIT_F() which takes the fixture name and a setup and teardown
+function to be defined subsequently. Note that there are
+no start brace, which is intentional::
+
+	DECLARE_F(a_fixture)
+		int value;
+		struct my_details;
+		...
+	};
+        INIT_F(a_fixture, a_setup, a_teardown);
+
+Then to the implementation of the fixture, in the form of actual setup and
+a teardown functions that may operate on the attributes of the fixture::
+
+	SETUP_F(a_fixture, a_setup)
+	{
+		a_fixture->value = 42; /* or whatever.. */
+		<other actions needed to set up>
+		/* If everything went well during setup: */
+		a_fixture->ok = true;
+	}
+
+	TEARDOWN_F(a_fixture, a_teardown)
+	{
+		<necessary cleanup code>
+	}
+
+Now individual tests that uses this fixture can be declared with::
+
+	TEST_F(a_fixture, suite_name, test_name)
+	{
+		<test code>
+	}
+
+Contexts
+********
+
+A context provides a way to instantiate a test in multiple ways.
+A typical use case is if you have multiple similar devices
+you want to run a set of tests on. Another use case could be that
+you want to run a set of tests under different configurations.
+
+You are free to let the number and names of these contexts
+vary as to where you run your test. For the devices use case, you can
+have the init function loop through all available devices, to identify
+the ones the tests applies to, then instantiate a context for each
+device, possibly using the device name for trackability. The context
+names will be prepended to the test name and the number of available
+tests will be multipled by the number of contexts.
+
+Note that the state of a context persists through the whole "life" of
+the module (until it gets unloaded) so it can be used to store more
+long term bookeeping in addition to any configuration information.
+The test writer must make sure that subsequent runs of the test suite
+(or parallel runs!) does not interfere with
+each other. Similar to fixtures, there's a generic part that KTF uses,
+and it can be extended the normal way. Make sure to declare the
+test specific context struct type with an element named::
+
+	struct ktf_context k;
+
+typically as the first element of the struct, then you can continue
+with whatever other datastructure desired. A test module can declare
+and use as many contexts as desired. Note that contexts are associated
+with and unique within a ``handle`` (see below). So if you need
+to use a different set of contexts for different tests, you need to
+put these contexts and tests into different handles.
+
+A context can be added using something like::
+
+	KTF_CONTEXT_ADD(&my_struct.k, "mycfg")
+
+where the first argument is a reference to the ktf_context structure
+within the test specific structure, and the second argument is a text
+name to use to refer to the context. Once one or more contexts exists
+for a handle, tests for that handle will show up with names postfixed
+by the context name, and there will be a distinct version of the test
+for each context, e.g if a handle has contexts named ``c1`` and
+``c2``, and tests declared with ``TEST(x, t1)`` and ``TEST(x, t2)``,
+then this will manifest as 4 tests::
+
+	x.t1_c1
+	x.t1_c2
+	x.t2_c1
+	x.t2_c2
+
+Tests that depends on having a context
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+It is likely that once you have a set of tests that uses contexts,
+that they also depends on a context being available, e.g. that the
+``ctx`` variable inside a test points to a non-nil context. One example
+use case for contexts would be a certain class of device. Such a
+device might or might not be available in the system. If one or more
+devices are available, you might want to have tests named
+``c.t1_dev1`` and ``c.t1_dev2`` where ``dev1`` and ``dev2`` are the
+device names for these devices in the system, but never have any
+``c.t1`` test without a device. You can
+enforce this by letting tests associated with a handle requiring a
+context to even show up as a test in the list or be available for
+execution. Instead of using ``KTF_INIT()`` or ``KTF_HANDLE_INIT()``,
+use ``KTF_CTX_INIT()`` or ``KTF_HANDLE_CTX_INIT()``.
+
+Configurable contexts
+~~~~~~~~~~~~~~~~~~~~~
+Sometimes it might be useful to be able to configure a context for the
+execution of some (or all) of the tests using the context.
+This can be because the system the tests are running on might have
+different hardware or software capabilities, or might rely on
+differing device or network setup or naming. Typically we want a unit
+test suite to have as little configuration and parameterization as
+possible, so recommended use is for parameters that is not directly
+related to the operation of the test, but more for situations where
+parameters outside the test itself needs to be set up, such as connect
+details for a network service to test against, or a peer unit test
+process for network related tests that require more than one
+system to run. To specify a configurable context, use::
+
+	int my_cfg_callback(struct ktf_context *ctx, const void* data, size_t data_sz);
+
+	KTF_CONTEXT_ADD_CFG(&my_struct.k, "mycfg", my_cfg_callback, type_id)
+
+The ``data`` pointer (and it's length) should be provided from user
+space, and it is up to the test specific user space and kernel space
+code to decide with the configuration is all about. If 0 is returned,
+KTF considers the context to be configured, otherwise it will retain
+it's current state, which will initially be unconfigured.
+The callback return value is stored as an errno value in ``ktf_context`` in the
+variable ``config_errno``, which will initially be set to ``ENOENT``,
+to indicate unconfigured. The test can use this value
+to decide what to do, such as failing with a message about missing
+configuration or just silently pass and ignore the case if not
+configured. The ``type_id`` parameter is used as a unique
+identifier for the kernel side to decide how to interpret the
+parameter, which is useful if different contexts wants to implement
+very different configuration options. It also allows two different
+test modules to use the same context names but with different
+parameters by using different context types.
+
+In the user space part of the test, configuration information
+can be set for a context using::
+
+	KTF_CONTEXT_CFG(name, type_id, parameter_type, parameter_ref)
+
+A simple example of a configurable test can be seen in
+the selftests test in ``selftest/context.c`` (kernel part) and
+``user/context.cpp`` (user part) and the header file
+``selftest/context_self.h`` shared between user space and kernel space.
+
+Context types and user space created contexts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Contexts belong to a ``context type``, which is a mechanism to group
+contexts into types that have similar properties. It is up to the
+kernel test module using these contexts what the meaning of this is,
+but a simple semantics can be that all contexts of a certain type has
+the same parameter block and the type ID can be used to check what
+type of context it is before trying to resolve or verify the
+parameters. For contexts pre-created by the kernel module, type IDs
+can be freely selected and does not have any further meaning beyond
+this.
+
+Context types can however also be used to selectively allow user
+space to dynamically create new contexts of a specific type. To enable
+such functionality, the kernel test module will need to enable it for
+one or more context types. This is done by means of the following call::
+
+	ktf_handle_add_ctx_type(struct ktf_handle *handle,
+				struct ktf_context_type *type)
+
+kernel side call, which tells KTF that a new context type with a given type ID
+permits user applications to create new contexts. This is useful for
+instance if user parameters or other information most easily
+obtainable from user land at test runtime is most easily available
+from user space.
+
+Handles
+*******
+
+Unlike user land unit test frameworks, which can rely on everything
+being cleaned up when the test program finished, KTF and test writers
+must pay the normal kernel level attention to allocations, references and
+deallocations.
+
+KTF itself uses the concept of a *handle* to track tests,
+test suites and contexts associated with a kernel module.
+Contexts are also associated with a handle. Since the availability of
+contexts for a handle determines the availability of tests and the
+naming of them, it can be useful to have separate spaces for tests
+that relies on some context and tests that do not, to avoid
+aggregating up multiple test cases that are identical.
+Handles thus also have a namespace effect in that it is possible to
+have two contexts with the same name, and possibly a different type,
+by putting them in different handles.
+
+The simplest mode of usage is for each module to use KTF_INIT() and
+KTF_CLEANUP() in it's __init and __exit functions. KTF_INIT implicitly declares and
+initializes a global handle __test_handle that gets cleaned up again
+in KTF_CLEANUP, making the handle something a test developer does not
+need to think too much about. However, sometimes a KTF kernel module
+may be such organized that it makes sense to use more than one handle.
+KTF allows the creation/cleanup of explicitly named handles by means of
+KTF_HANDLE_INIT(name) and KTF_HANDLE_CLEANUP(name). This can be used
+as an alternative to KTF_INIT()/KTF_CLEANUP() but requires the use of
+ADD_TEST_TO(handle, testname) instead of the normal ADD_TEST(testname)
+for adding tests to be executed.
diff --git a/Documentation/dev-tools/ktf/debugging.rst b/Documentation/dev-tools/ktf/debugging.rst
new file mode 100644
index 0000000..4f1d0ff
--- /dev/null
+++ b/Documentation/dev-tools/ktf/debugging.rst
@@ -0,0 +1,248 @@
+8. Debugging KTF
+--------------------
+
+Structured debugging/tracing by printf
+======================================
+
+The kernel side of KTF implements it's own simple printk based logging
+abstraction. You can create log entries by means of calls to the macro
+tlog(level, format,...) - level is a bitmask where individual bits
+represents log classes. You can read and set this bitmask via a
+writable ``/sys`` file::
+
+  # cat /sys/module/ktf/parameters/debug_mask
+  0x1
+  echo 0x3 > /sys/module/ktf/parameters/debug_mask
+  # cat /sys/module/ktf/parameters/debug_mask
+  0x3
+
+The default value of ``debug_mask`` is 0x1 = INFO level.
+Bits are by convention supposed to be
+ordered by verbosity, with the lowest bits reserved for low volume,
+important messages, while the higher bist are left for more verbose
+debugging. You can also use this mechanism for simple debugging of KTF's
+interaction with your tests, as the core KTF code contains some log
+statements to make it easier to follow and debug involved
+instances of KTF objects.
+
+Similarly, the user library implementing the interaction with the
+user land test runner can log details about this. You can enable such
+logging by providing a similar bitmask via the environment variable
+KTF_DEBUG_MASK.
+
+Debugging fatal errors in tests
+===============================
+
+So your KTF test crashed the kernel? Let's see how you can use crash to
+examine KTF test cases, individual test logs and see which test is running.
+
+First step is we need to load symbols for KTF.  To get text, data and
+bss section locations for the ktf module (assuming it's currently
+loaded)::
+
+	# cd /sys/module/ktf/sections
+	# cat .text .data .bss
+	0xffffffffa0bdb000
+	0xffffffffa0bdf000
+	0xffffffffa0bdf7a0
+
+Now run crash on your corefile (or /proc/kcore for a live kernel)::
+
+	# crash <path-to-Symbol.map> <path-to-vmlinux> <path-to-core>
+	crash> add-symbol-file /path/to/kernel/ktf.ko 0xffffffffa0bdb000 -s .data 0xffffffffa0bdf000 -s .bss 0xffffffffa0bdf7a0
+
+Now we can see the global test_cases rbtree via the handy
+"tree" command. It displays an rbtree, and because test_cases
+is an rbtree under the hood we can display the set of test
+cases as follows::
+
+	crash>  tree -t rbtree -s ktf_case test_cases
+	ffff88036f710c00
+	struct ktf_case {
+	  kmap = {
+	    node = {
+	      __rb_parent_color = 1,
+	      rb_right = 0x0,
+	      rb_left = 0x0
+	    },
+	    key = "selftest\000cov\000probereturn\000probeentry\000wrongversion\000dummy\000simplemap",
+	    map = 0xffffffffa0bdd1a0 <test_cases>,
+	    refcount = {
+	      refcount = {
+	        counter = 2
+	      }
+	    }
+	  },
+	  tests = {
+	    root = {
+	      rb_node = 0xffff880250ac4a00
+	    },
+	    size = 5,
+	    lock = {
+	      {
+	        rlock = {
+	          raw_lock = {
+	            {
+	              head_tail = 655370,
+	              tickets = {
+	                head = 10,
+	                tail = 10
+	              }
+	            }
+	          }
+	        }
+	      }
+	    },
+	    elem_comparefn = 0x0,
+	    elem_freefn = 0xffffffffa0bd8760 <ktf_test_free>
+	  },
+	  debugfs = {
+	    debugfs_results_testset = 0xffff88021a18a3c0,
+	    debugfs_results_test = 0xffff88021a18aa80,
+	    debugfs_run_testset = 0xffff88021a18a300,
+	    debugfs_run_test = 0xffff88021a18a840
+	  }
+	}
+
+Here we had 1 test case - from the "key" field
+we can see it is called "selftest" - in fact it is
+KTF's self tests. Within that one test cases we see
+the rbtree for the indivdual selftest tests has a root
+rb_node::
+
+	  tests = {
+	    root = {
+	      rb_node = 0xffff880250ac4a00
+	    },
+
+By printing _that_ tree of ktf_test structures from
+root node (-N) 0xffff880250ac4a00 we can see our
+individual tests::
+
+	crash> tree -t rbtree -s ktf_test -N 0xffff880250ac4a00
+	ffff880250ac4a00
+	struct ktf_test {
+	  kmap = {
+	    node = {
+	      __rb_parent_color = 1,
+	      rb_right = 0xffff880250ac5b00,
+	      rb_left = 0xffff880250ac5d00
+	    },
+	    key = "probeentry\000wrongversion\000dummy\000simplemap\000\000\000\000\000\020\276\240\377\377\377\377 \020\276\240\377\377\377\377@\020\276\240\377",
+	    map = 0xffff88036f710c68,
+	    refcount = {
+	      refcount = {
+	        counter = 2
+	      }
+	    }
+	  },
+	  tclass = 0xffffffffa0be41a4 "selftest",
+	  name = 0xffffffffa0be41bd "probeentry",
+	  fun = 0xffffffffa0be1920,
+	  start = 0,
+	  end = 1,
+	  skb = 0xffff88003fc03800,
+	  log = 0xffff88003fa58000 "",
+	  lastrun = {
+	    tv_sec = 1506072537,
+	    tv_nsec = 289494591
+	  },
+	  debugfs = {
+	    debugfs_results_testset = 0x0,
+	    debugfs_results_test = 0xffff88021a18ac00,
+	    debugfs_run_testset = 0x0,
+	    debugfs_run_test = 0xffff88021a18af00
+	  },
+	  handle = 0xffffffffa0be5480
+	}
+	ffff880250ac5d00
+	struct ktf_test {
+	  kmap = {
+	    node = {
+	      __rb_parent_color = 18446612142257621505,
+	      rb_right = 0x0,
+	      rb_left = 0xffff880250ac4b00
+	    },
+	    key = "dummy\000simplemap\000\000\000\000\000\020\276\240\377\377\377\377 \020\276\240\377\377\377\377@\020\276\240\377\377\377\377`\020\276\240\377\377\377\377\200\020\276\240\377\377\377\377\320\020\276\240\377",
+	    map = 0xffff88036f710c68,
+	    refcount = {
+	      refcount = {
+	        counter = 2
+	      }
+	    }
+	  },
+	  tclass = 0xffffffffa0be41a4 "selftest",
+	  name = 0xffffffffa0be41d5 "dummy",
+	  fun = 0xffffffffa0be10f0,
+	  start = 0,
+	  end = 1,
+	  skb = 0xffff88003fc03800,
+	  log = 0xffff88003fa59800 "",
+	  lastrun = {
+	    tv_sec = 1506072537,
+	    tv_nsec = 289477354
+	  },
+	  debugfs = {
+	    debugfs_results_testset = 0x0,
+	    debugfs_results_test = 0xffff88021a18a900,
+	    debugfs_run_testset = 0x0,
+	    debugfs_run_test = 0xffff88021a18a9c0
+	  },
+	  handle = 0xffffffffa0be5480
+	}
+	...
+	crash>
+
+
+The "log" fields are empty as each test passed, but we can
+see from the "lastrun" times when the tests were run.
+Logs will contain assertion failures etc in case of failure.
+
+Note that each test has a "handle" field also - this is
+the KTF handle which was used to register the test. Each
+handle also shows the currently-executing (if in the middle
+of a test run) test associated with it, so if we want to
+see where test execution was we can simply print the handle::
+
+	crash> print *(struct ktf_handle *)0xffffffffa0be5480
+	$13 = {
+	  test_list = {
+	    next = 0xffffffffa0be5480,
+	    prev = 0xffffffffa0be5480
+	  },
+	  handle_list = {
+	    next = 0xffffffffa0be5490,
+	    prev = 0xffffffffa0be5490
+	  },
+	  ctx_map = {
+	    root = {
+	      rb_node = 0x0
+	    },
+	    size = 0,
+	    lock = {
+	      {
+	        rlock = {
+	          raw_lock = {
+	            {
+	              head_tail = 0,
+	              tickets = {
+	                head = 0,
+	                tail = 0
+	              }
+	            }
+	          }
+	        }
+	      }
+	    },
+	    elem_comparefn = 0x0,
+	    elem_freefn = 0x0
+	  },
+	  id = 0,
+	  version = 4294967296,
+	  current_test = 0x0
+	}
+	crash>
+
+In this case current_test is NULL, but if we crashed in the
+middle of executing a test it would show us which struct ktf_test *
+it was.
diff --git a/Documentation/dev-tools/ktf/examples.rst b/Documentation/dev-tools/ktf/examples.rst
new file mode 100644
index 0000000..ec1f6e9
--- /dev/null
+++ b/Documentation/dev-tools/ktf/examples.rst
@@ -0,0 +1,26 @@
+6. Example test code
+--------------------
+
+Here is a minimal dummy example of a KTF unit test suite that defines
+two tests, ``hello_ok`` and ``hello_fail``. The test is in the examples
+directory and is built with KTF:
+
+.. literalinclude:: ../examples/hello.c
+   :language: c
+
+To run the test, cd to your KTF build tree and insmod the ktf module and
+the module that provides the test::
+
+    insmod kernel/ktf.ko
+    insmod examples/hello.ko
+
+Now you should be able to run one or more of the tests by running the
+application ``ktfrun`` built in ``user/ktfrun``. You should be able to run
+that application as an ordinary user::
+
+    ktfrun --gtest_list_tests
+    ktfrun --gtest_filter='*fail'
+    ktfrun --gtest_filter='*ok'
+
+There are more examples in the examples directory. KTF also includes a
+``selftest`` directory used to test/check the KTF implementation itself.
diff --git a/Documentation/dev-tools/ktf/features.rst b/Documentation/dev-tools/ktf/features.rst
new file mode 100644
index 0000000..2dc736c
--- /dev/null
+++ b/Documentation/dev-tools/ktf/features.rst
@@ -0,0 +1,307 @@
+3. KTF kernel specific features
+-------------------------------
+
+Reference to module internal symbols
+************************************
+
+When working with unit tests, the need to access non-public interfaces
+often arises. In general non-public interfaces is of course not intended to
+be used by outside programs, but a test framework is somewhat special here
+in that it is often necessary or desirable to unit test internal
+data structures or algorithms even if they are not exposed. The program
+under test may be a complicated beast by itself and merely exercising the
+public interfaces may not be flexible enough to stress the internal code.
+Even if it is possible to get the necessary "pressure" from the outside
+like that, it might be much more challenging or require a lot more work.
+
+The usual method to gain access to internal interfaces is to be part of the
+internals. To some extent this is the way a lot of the kernel testing
+utilities operate. The obvious advantages of this is that the test code
+'automatically' follows the module and it's changes. The disadvantage is
+that test code is tightly integrated with the code itself. One important
+goal with KTF is to make it possible to write detailed and sophisticated
+test code which does not affect the readability or complexity of the tested
+code.
+
+KTF contains a small python program, ``resolve``, which
+parses a list of symbol names on the form::
+
+    #module first_module
+    #header first_header.h
+    private_symbol1
+    private_symbol2
+    ...
+    #header second_header.h
+    #module next_module
+    ...
+
+The output is a header file and a struct containing function pointers and
+some convenience macro definitions to make it possible to 'use' the
+internal functions just as one would if within the module. This logic is
+based on kallsyms, and would of course only work if that functionality is
+enabled in the kernel KTF compiles against. Access to internal symbols
+this way is controlled by the kernel config options CONFIG_KALLSYMS
+and CONFIG_KALLSYMS_ALL, which must be set to "y".
+
+If you create a new test project using the ``ktfnew`` script, you can
+put your private symbol definitions in a file ``ktf_syms.txt`` in the
+kernel directory, and KTF will automatically generate ``ktf_syms.h``,
+which you can then include in your test file to get to these symbols.
+This functionality is also used by the KTF selftests, which might
+serve as an example to get started.
+
+Note also that for exported symbols, if you build your module out-of-tree in
+addition to KTF and the test modules, you might need to also add those
+module's ``Module.symvers`` files to ``KBUILD_EXTRA_SYMBOLS``
+(See kernel documentation for this) to find them during test module build.
+
+Requesting callbacks when a certain function gets called/returns
+****************************************************************
+
+Tap into function entry using KTF entry probes.  Many tests need to
+move beyond kernel APIs and ensure that side effects (logging a
+message etc) occur.  A good way to do this is to probe entry of relevant
+functions.  In order to do so in KTF you need to:
+
+    - define an entry probe function with the same return value and arguments
+      as the function to be probed
+
+    - within the body of the entry probe function, ensure return is wrapped with
+      KTF_ENTRY_PROBE_RETURN(<return value>);
+
+    - entry probes need to registered for use and de-registered when done via
+      KTF_[UN]REGISTER_ENTRY_PROBE(<kernel function name>, <handler function>).
+
+See example h4.c in examples/ for a simple case where we probe printk() and
+ensure it is called.
+
+Sometimes is is also useful to check that an intermediate function is returning
+an expected value.  Return probes can be used to register/probe function
+return.  In order to probe function return:
+
+    - define a return probe point; i.e
+      KTF_RETURN_PROBE(<kernel function>, <handler>)
+
+    - within the body of the return probe the return value can be retrieved
+      via KTF_RETURN_VALUE().  Type will obviously depend on the function
+      probed so should be cast if dereferencing is required.
+
+    - return probes need to be registered for use and unregistered when done
+      via KTF_[UN]REGISTER_RETURN_PROBE(<kernel function name>, <handler>).
+
+See example h4.c in examples/ for a simple case where we verify return value
+of printk().
+
+Note that this functionality is only available on kernels with CONFIG_KPPROBES
+and CONFIG_KRETPROBES set to "y".
+
+Overriding functions
+********************
+in some cases, we wish to override harmful functions when inducing failues in
+tests (e.g. skb_panic()). Override is done via kprobes and we define as follows::
+
+    KTF_OVERRIDE(oldfunc, newfunc)
+    {
+	...
+	KTF_SET_RETURN_VALUE(1);
+	KTF_OVERRIDE_RETURN;
+    }
+
+    TEST(...)
+    {
+	KTF_REGISTER_OVERRIDE(oldfunc, newfunc);
+	...
+	KTF_UNREGISTER_OVERRIDE(oldfunc, newfunc);
+    }
+
+Override should be used sparingly; we'd rather test the code as-is and use
+entry/return probes where possible.
+
+Note that this functionality is only available on kernels with CONFIG_KPPROBES
+and CONFIG_KRETPROBES set to "y".
+
+Coverage analytics
+******************
+
+While other coverage tools exist, they generally involve gcc-level support
+which is required at compile-time.  KTF offers kernel module coverage
+support via kprobes instead.  Tests can enable/disable coverage on a
+per-module basis, and coverage data can be retrieved via::
+
+    # more /sys/kernel/debug/ktf/coverage
+
+For a given module we show how many of its functions were called versus the
+total, e.g.::
+
+    # cat /sys/kernel/debug/ktf/coverage
+    MODULE               #FUNCTIONS    #CALLED
+    selftest             14            1
+
+We see 1 out of 14 functions was called when coverage was enabled.
+
+We can also see how many times each function was called::
+
+    MODULE          FUNCTION                   COUNT
+    selftest        myelem_free                0
+    selftest        myelem_cmp                 0
+    selftest        ktf_return_printk          0
+    selftest        cov_counted                1
+    selftest        dummy                      0
+
+In addition, we can track memory allocated via kmem_cache_alloc()/kmalloc()
+originating from module functions we have enabled coverage for.  This
+allows us to track memory associated with the module specifically to find
+leaks etc.  If memory tracking is enabled, /sys/kernel/debug/ktf/coverage
+will show outstanding allocations - the stack at allocation time; the
+memory address and size.
+
+Coverage can be enabled via the "ktfcov" utility.  Syntax is as follows::
+
+    ktfcov [-d module] [-e module [-m]]
+
+"-e" enables coverage for the specified module; "-d" disables coverage.
+"-m" in combination with "-e" enables memory tracking for the module under
+test.
+
+Note that this functionality is only available on kernels with CONFIG_KPPROBES
+and CONFIG_KRETPROBES set to "y", and that CONFIG_KALLSYMS and
+CONFIG_KALLSYMS_ALL should be set to "y" also to get all exported and
+non-exported symbols.
+
+Thread execution
+****************
+
+KTF provides easy mechanisms to create and use kernel threads.
+Assertions can then be carried out in the created thread context
+also.  Threads can be created as follows, and we can if we wish
+wait for thread completion::
+
+
+    TEST(foo, bar)
+    {
+        struct ktf_thread t;
+
+        ...
+        KTF_THREAD_INIT(mythread, &t);
+        KTF_THREAD_RUN(&t);
+        KTF_THREAD_WAIT_COMPLETED(&t);
+        ...
+    }
+
+The thread itself is defined as follows::
+
+    KTF_THREAD(mythread)
+    {
+        ...
+    }
+
+We can add assertions to the thread and they will be recorded/logged
+as part of the test.
+
+Hybrid tests
+************
+
+KTF also allows mixing of user and kernel side code in the same test.
+This is useful if one wants for instance to verify that user land operations
+has certain effects in the kernel, for instance verify that a parameter is
+transferred or handled correctly in the kernel.
+
+Hybrid tests are specified by writing a user mode test using the special
+``HTEST()`` macro instead of the normal ``TEST()`` macro. This macro takes
+Inside the macro, the special variable ``self`` can be used to refer to the
+test itself, and the macro ``KTF_USERDATA()`` can be used to get a pointer to
+an allocated instance of a test specific parameter struct. The user land test
+can then call the kernel side directly using ``ktf::run_kernel_test(self)`` An
+optional context name can be specified as a second argument to the call if
+needed. This can be done any number of times during the user land test and
+each call will transmit the struct value out-of-band to the kernel side. To
+the kernel this appears as separate test calls, but the kernel side have the
+option of aggregating or otherwise maintain state for the duration of the
+test.
+
+Declare the data structure to use for user/kernel out-of-band communication
+in a header file that is included both by the user and the kernel side::
+
+    struct my_params
+    {
+	char expected[128];
+	unsigned long mode;
+    };
+
+The user land side of the test itself can then look like this::
+
+    HTEST(foo, hybrid)
+    {
+	KTF_USERDATA(self, my_params, data);
+
+	<normal gtest code>
+
+	strcpy(data->expected, "something");
+	data->mode = 0;
+        ktf::run_kernel_test(self);
+
+	strcpy(data->expected, "something_else");
+	ktf::run_kernel_test(self);
+
+	<normal gtest code>
+
+	...
+    }
+
+On the kernel side, a hybrid test is written as a normal kernel test using
+the ``TEST()`` macro, and the test must be added using ``ADD_TEST()`` as
+usual. Include the user land header file to know the data type of the
+out-of-band parameter block. Invoke the macro ``KTF_USERDATA()`` to get a
+size validated pointer to the user land provided data. If no data is
+available, the test will silently exit. This is by purpose - if the kernel
+test is executed from a test program that does not have the associated user
+land code, such as for instance ``ktfrun``, it will just appear as a test
+with no assertions in it, and not create any errors. If on the other hand the
+parameter block does not match in size, an assertion is thrown and the test
+exits::
+
+    TEST(foo, hybrid)
+    {
+	KTF_USERDATA(self, my_params, data);
+
+	...
+	if (strcmp(data->expected, "something") == 0)
+	   ...
+	   EXPECT( ... )
+
+ 	...
+    }
+
+
+Running tests and examining results via debugfs
+***********************************************
+
+In addition to the netlink interface used by the Googletest integrated frontend code,
+we provide debugfs interfaces for examining the results of the
+last test run and for running tests which do not require configuration
+specification. Individual ktf testsets can be run via::
+
+    cat /sys/kernel/debug/ktf/run/<testset>
+
+Individual tests can be run via::
+
+    cat /sys/kernel/debug/ktf/run/<testset>-tests/<test>
+
+Results can be displayed for the last run via::
+
+    cat /sys/kernel/debug/ktf/results/<testset>
+
+Individual tests can be run via::
+
+    cat /sys/kernel/debug/ktf/results/<testset>-tests/<test>
+
+These interfaces bypasses use of the netlink socket API
+and provide a simple way to keep track of test failures.  It can
+be useful to log into a machine and examine what tests were run
+without having console history available.
+
+In particular::
+
+    cat /sys/kernel/debug/ktf/run/*
+
+...is a useful way of running all KTF tests.
diff --git a/Documentation/dev-tools/ktf/implementation.rst b/Documentation/dev-tools/ktf/implementation.rst
new file mode 100644
index 0000000..2bc4335
--- /dev/null
+++ b/Documentation/dev-tools/ktf/implementation.rst
@@ -0,0 +1,70 @@
+
+2. Implementation
+-----------------
+
+KTF consists of a kernel part and a user part. The role of the user part is to query the kernel
+for available tests, and provide mechanisms for executing a selected set or all the available
+tests, and report the results. The core ktf kernel module simply provides some APIs to write
+assertions and run tests and to communicate about tests and results with user mode.
+A simple generic Netlink protocol is used for the communication.
+
+User mode implementation
+************************
+
+Since test filtering and reporting is something existing unit test frameworks for
+user space code already does well, the implementation of KTF simply leverages that.
+The current version supports an integration with gtest (Googletest), which provides a lot of
+these features in a flexible way, but in principle alternative implementations could
+use the reporting of any other user level unit test framework. The use of gtest also allows this
+documentation to be shorter, as many of the features in gtest are automatically available for KTF as well.
+More information about Googletest features can be found here: https://github.com/google/googletest
+
+Kernel mode implementation
+**************************
+
+The kernel side of KTF implements a simple API for tracking test modules,
+writing tests, support functions and and a set of assertion macros, some
+tailored for typical kernel usage, such as ``ASSERT_OK_ADDR_GOTO()``
+as a kernel specific macro to check for a valid address with a label to jump to if the
+assertion fails. After all as we are still in the kernel, tests would always need to clean up for
+themselves even though in the context of ktf.
+
+KTF supports two distinct classes of tests:
+
+* Pure kernel mode tests
+* Hybrid tests
+
+Pure kernel mode tests are tests that are fully implemented in kernel space.
+This is the most straightforward mode and resembles ordinary user land unit testing
+in kernel mode. If you only have kernel mode tests, you will only ever need one user level program
+similar to user/ktfrun.cpp, since all test development takes place on the kernel side.
+
+Hybrid tests are for testing and making assumptions about the user/kernel communication, for instance
+if a parameter supplied from user mode is interpreted the intended way when it arrives at it's kernel
+destination. For such tests you need to tell ktf (from user space) when the kernel part of the test
+is going to be executed - this can happen multiple times depending on your test needs.
+Apart from that it works mostly like a normal gtest user level test.
+
+Kernel integration of KTF or KTF as a separate git project?
+***********************************************************
+
+Yes. A lot of test infrastructure and utilities for the Linux kernel
+is implemented as part of the linux kernel git project.
+This has some obvious benefits, such as
+
+* Always being included
+* When APIs are changed, test code can be updated atomically with the rest of the kernel
+* Higher visibility and easier access
+* Easier integration with internal kernel interfaces useful for testing.
+
+On the other hand providing KTF as a separate project allows
+
+* With some use of ``KERNEL_VERSION`` and ``LINUX_VERSION_CODE``, up-to-date KTF code and tests
+  can be allowed to work across kernel versions.
+* This in turn allows a single set of newly developed tests to be
+  simultaneously tested against multiple older kernels, possibly
+  detecting more bugs, or instances of bugs not backported.
+
+So we will continue to support both, and have work in progress to simplify
+the maintenance and synchronization of the two versions, and allow the
+additional tooling to extend to KTF client test suites as well.
diff --git a/Documentation/dev-tools/ktf/index.rst b/Documentation/dev-tools/ktf/index.rst
new file mode 100644
index 0000000..25db49b
--- /dev/null
+++ b/Documentation/dev-tools/ktf/index.rst
@@ -0,0 +1,14 @@
+Kernel Test Framework documentation
+===================================
+
+.. toctree::
+   :maxdepth: 2
+
+   introduction
+   implementation
+   features
+   installation
+   concepts
+   examples
+   progref
+   debugging
diff --git a/Documentation/dev-tools/ktf/installation.rst b/Documentation/dev-tools/ktf/installation.rst
new file mode 100644
index 0000000..1bfccc1
--- /dev/null
+++ b/Documentation/dev-tools/ktf/installation.rst
@@ -0,0 +1,73 @@
+4. Building and installing KTF
+------------------------------
+
+KTF's user land side depends on googletest.
+The googletest project has seen some structural changes in moving from a
+project specific gtest-config via no package management support at all to
+recently introduce pkgconfig support. This version of KTF only supports
+building against a googletest (gtest) with pkgconfig support, which means
+that as of February 2018 you have to build googletest from source at
+github.
+
+Googletest has also recently been fairly in flux, and while we
+try to keep up to date with the official googletest version on Github,
+we have seen issues with changes that breaks KTF. We also have a small
+queue of enhancements and fixes to Googletest based on our experience
+and use of it a.o. with KTF. You can find the latest rebase of this
+version in the ktf branch of knuto/googletest at Github, but expect it
+to rebase as we move forward to keep it up-to-date.
+This version will at any time have been tested with KTF by us, since
+we use it internally. Let's assume for the rest of these instructions
+that your source trees are below ``~/src`` and your build trees are
+under ``~/build``::
+
+	cd ~/src
+	git clone https://github.com/knuto/googletest.git
+
+or::
+
+        cd ~/src
+        git clone https://github.com/google/googletest.git
+
+then::
+
+	mkdir -p ~/build/$(uname -r)
+	cd ~/build/$(uname -r)
+	mkdir googletest
+	cd googletest
+	cmake ~/src/googletest
+	make
+	sudo make install
+
+Default for googletest is to use static libraries.  If you want to use shared
+libraries for googletest, you can specify ``-DBUILD_SHARED_LIBS=ON`` to
+cmake. If you don't want to install googletest into /usr/local, you can
+specify an alternate install path using ``-DCMAKE_INSTALL_PREFIX=<your path>``
+to cmake for googletest, and similarly use ``--prefix=<your path>`` both for
+KTF and your own test modules. Note that on some distros, cmake version
+2 and 3 comes as different packages, make sure you get version 3, which may
+require you to use ``cmake3`` as command instead of cmake above.
+
+Building the in-kernel version of KTF and running KTF selftests
+***************************************************************
+
+The environment needs to have the path to the
+gtest (Googletest) build set to the directory above the lib and
+include directories::
+
+    export GTEST_PATH=$HOME/install
+
+KTF can then be built using the module target, eg. from the top level
+kernel build tree.
+
+    make M=tools/testing/selftests/ktf
+
+You can run also build (and run) KTF tests as selftests tests
+via the kselftest target::
+
+    make TARGETS="ktf" kselftest
+
+You can invoke this command to let the tests run as a normal user, but
+root access is needed to load and unload ktf.ko and the test
+module(s). This will happen as part of the kselftest target even as a
+normal user if the user has sudo privileges.
diff --git a/Documentation/dev-tools/ktf/introduction.rst b/Documentation/dev-tools/ktf/introduction.rst
new file mode 100644
index 0000000..5c861f4
--- /dev/null
+++ b/Documentation/dev-tools/ktf/introduction.rst
@@ -0,0 +1,134 @@
+:Author: Knut Omang <knut.omang@oracle.com>
+:Last Updated: Alan Maguire <alan.maguire@oracle.com>
+
+1. Background and motivation
+----------------------------
+
+Kernel Test Framework (KTF) implements a unit test framework for the Linux kernel.
+There's a wide selection of unit test frameworks available for normal user land
+code testing, but we have so far not seen any similar frameworks that can be used
+with kernel code, to test details of both exported and non-exported kernel APIs.
+The hope is that providing an easy to use and convenient way to write simple unit
+tests for kernel internals, that this can promote a more test driven approach to
+kernel development, where appropriate.
+
+An important design goal is to make KTF in a way that it lend itself well to a normal kernel
+developer cycle, and that it integrates well with user land unit testing, to allow kernel and
+user land tests to behave, look and feel as similar as possible. This should hopefully make it
+more intuitive to use as well as more rewarding. We also believe that even a kernel test that
+passes should have a nice, easy to read and pleasant output, and that a test framework must have
+good observability, that is good mechanisms for debugging what went wrong, both in case of bugs
+in the tests and and the test framework itself.
+
+KTF is designed to test the kernel in the same ways it runs. This means we want to stay away from
+changing configuration options, or otherwise make changes that makes it hard to logically tell
+from a high level perspective whether the kernel with KTF is really logically "the same" as the
+kernel our users are exposed to. Of course we all know that it is very hard to test anything
+without affecting it, with quantum mechanics as the extreme, but at least we want to make an
+effort to make the footprint as small as possible.
+
+KTF tests kernel code by running tests in kernel context - or in the case of hybrid tests - in
+both user- and kernel contexts. Doing this ensures that we test kernel codepaths in a real way,
+without emulating a kernel execution environment. This gives us vastly more control over what
+tests can do versus user-space driven testing, and increases confidence that what the tests test
+matches what the kernel does since the test execution environment is identical.
+
+KTF is a product of a refactoring of code used as part of test driven development of a Linux
+driver for an Infiniband HCA. It is in active use for kernel component testing within Oracle.
+
+Test driven development
+***********************
+
+Unit testing is an important component of Test driven development (TDD).
+The idea of test driven development is that when you have some code to write,
+whether it is a bug to fix, or a new feature or enhancement, that you start by writing
+one or more tests for it, have those tests fail, and then do the actual development.
+
+Typically a test driven development cycle would have several rounds of development and
+test using the new unit tests, and once the (new) tests pass, you would
+also run all or a suitable subset (limited by execution time) of the old tests to verify
+that you have not broken any old functionality by the new code.
+
+At this stage it is important that the tests that are run can be run quickly to allow
+them to be actively used in the development cycle. When time comes for
+submission of the code, a full, extensive set of both the tests the developer thinks
+can touch the affected code *and* all the other tests should be run, and a longer time
+to run tests can be afforded.
+
+KTF tries to support this by using the module system of the kernel to support
+modularized test suites, where a user only need to insmod the test subsets that he/she wants
+to use right then. Different test suites may touch and require different kernel APIs and have
+lots of different module and device requirements. To enable as much reuse of the functionality
+of code developed within KTF it is important that any piece of test code has as few dependencies
+as possible.
+
+Good use cases for KTF
+**********************
+
+Unit testing is at it's most valuable when the code to test is relatively error prone, but still
+might be difficult to test in a systematic and reproducable way from a normal application level.
+It can be difficult to trigger corner cases from a high abstraction layer,
+the code paths we want to exercise might only be used occasionally, or we want to exercise
+that error/exception scenarios are handled gracefully.
+
+KTF comes to it's strength in testing kernel APIs that are fairly integrated into the kernel,
+and depend upon lots of components, making them difficult or error prone to mock. Good examples
+are module APIs not easily testable from user land. Exported module APIs are usually only used
+by one or a few other kernel clients, and hitting buggy corner cases with these might be hard or
+impossible. This typically leads to bugs detected "down the road", when some new client appears
+and starts using the API in a new way, or instabilities that go undetected because underlying
+semantics that the implementation implicitly depend upon changes in subtle ways.
+
+KTF can use mechanisms such as KTF probes in cases where calls to other functions needs to be
+intercepted and/or modified to create the right test condition, whether it means waiting for a
+potential race condition to occur, or return an error value, or just collect state to make assertions.
+
+Typical classical use cases that lend itself well to unit testing are simple APIs with a relativ
+complex implementation - such as container implementations. Typical kernel examples of these
+in the kernel are scatterlist, rbtree, list, XArray etc. When testing the base implementations of such
+containers, bringing them entirely out into user space and compiling them standalone require some
+additional work up-front to implement mock interfaces to the services provided by the kernel,
+but may nonetheless be rewarding in the longer run, as such tests have at it's disposal the whole
+arsenal of user land tools, such as gdb, valgrind etc. This, however does not guarantee against
+wrong use of a container, such as with interactions between a container and a driver
+datastructure.
+
+Testing the *instantiations* of these container implementations inside drivers or
+the kernels's own internals might not be that easy with a user land approach, as it very quickly
+requires a prohibitive amount of mock interfaces to be written. And even when such mock
+interfaces can be written, one cannot be sure that they implement exactly the same as the
+environment that the code executes in within the kernel. Having the ability to make tests within
+a release kernel, even run the same tests against multiple such kernels is something KTF
+supports well. Our experience is that even error scenarios that are hard to reproduce by
+running applications on the kernel can often be reproduced with a surprisingly small
+number of lines of code in a KTF test, once the problem is understood. And writing that code can
+be a very rewarding way of narrowing down a hard bug.
+
+When *not* to use KTF
+*********************
+
+Writing kernel code has some challenges compared to user land code.
+KTF is intended for the cases where it is not easy to get coverage by writing
+simple tests from user land, using an existing rich and well proven user land unit test
+framework.
+
+Why *you* would want to write and run KTF tests
+***********************************************
+
+Besides the normal write test, write code, run test cycle of development and the obvious benefits of
+delivering better quality code with fewer embarrassments, there's a few other upsides from
+developing unit test for a particular area of the kernel:
+
+* A test becomes an invariant for how the code is supposed to work.
+  If someone breaks it, they should detect it and either document the changes that caused the breakage
+  by fixing the test or realize that their fix is broken before you even get to spend time on it.
+
+* Kernel documentation while quite good in some places, does not always
+  cover the full picture, or you might not find that sentence you needed while looking for it.
+  If you want to better understand how a particular kernel module actually works, a good way is to
+  write a test that codes your assumptions. If it passes, all is well, if not, then you have gained some
+  understanding of the kernel.
+
+* Sometimes you may find yourself relying on some specific feature or property of the kernel.
+  If you encode a test that guards the assumptions you have made, you will capture if someone
+  changes it, or if your code is ported to an older kernel which does not support it.
diff --git a/Documentation/dev-tools/ktf/progref.rst b/Documentation/dev-tools/ktf/progref.rst
new file mode 100644
index 0000000..2f0fa48
--- /dev/null
+++ b/Documentation/dev-tools/ktf/progref.rst
@@ -0,0 +1,144 @@
+7. KTF programming reference
+----------------------------
+
+KTF itself contains no tests but provides primitives and data structures to
+allow tests to be maintained and written in separate test modules that
+depend on the KTF APIs.
+
+KTF API Overview
+****************
+
+For reference, the following table lists a few terms and classes of
+abstractions provided by KTF. These are kernel side, if not otherwise noted:
+
++----------------------------+--------------------------------------------------+
+| **Item**		     | **description** 				        |
++============================+==================================================+
+| Test module		     | A kernel object file (.ko) with ktf tests in it	|
++----------------------------+--------------------------------------------------+
+| struct ktf_handle	     | At least 1 per test module.                      |
+|		   	     | Use macros KTF_INIT() and KTF_CLEANUP() to set up|
+|			     | and tear down handles.				|
++----------------------------+--------------------------------------------------+
+| struct ktf_context	     | 0-n per test module - test module specific       |
+|		     	     | context for the test, such as eg. a device or    |
+|		     	     | another kernel object.		                |
++----------------------------+--------------------------------------------------+
+| KTF_INIT()		     | Call this at the global level in the main file   |
+|			     | for each test module. Declares an implicit, 	|
+|			     | default test handle used by macros which do not  |
+|			     | provide a handle argument.			|
++----------------------------+--------------------------------------------------+
+| KTF_CTX_INIT()	     | Use this instead of KTF_INIT if the tests require|
+|			     | a context to execute. Tests will only show up as |
+| 			     | options if a context has been provided.		|
++----------------------------+--------------------------------------------------+
+| KTF_HANDLE_INIT(handle)    | Declare a named handle to associate tests and	|
+|			     | contexts with. This is an alternative to 	|
+|			     | KTF_INIT() to allow the use of separate test 	|
+|			     | handles for separate sets of tests.	    	|
++----------------------------+--------------------------------------------------+
+| KTF_HANDLE_CTX_INIT(handle)| Equivalent of KTF_CTX_INIT for a named handle	|
++----------------------------+--------------------------------------------------+
+| KTF_CLEANUP()		     | Call this in the __exit function to clean up     |
++----------------------------+--------------------------------------------------+
+| KTF_CONTEXT_ADD(ctx, name) | Add a new context to the default handle		|
++----------------------------+--------------------------------------------------+
+| KTF_CONTEXT_FIND(name)     | Return a struct ktf_context reference to	context	|
+| 			     | 'name', if it exists		     		|
++----------------------------+--------------------------------------------------+
+| KTF_CONTEXT_GET(name,type) | Return the structure of type 'type' containing   |
+| 			     | the ktf_context named 'name', if 'name' exists.  |
++----------------------------+--------------------------------------------------+
+| KTF_CONTEXT_REMOVE(ctx)    | Remove a previously added context from KTF	|
++----------------------------+--------------------------------------------------+
+| EXPECT_*		     | non-fatal assertions                             |
++----------------------------+--------------------------------------------------+
+| ASSERT_*		     | "fatal" assertions that would cause return/goto	|
++----------------------------+--------------------------------------------------+
+| TEST(s, n) {...}	     | Define a simple test named 's.n' with implicit 	|
+|		     	     | arguments 'ctx' and '_i' for context/iteration.  |
++----------------------------+--------------------------------------------------+
+| DECLARE_F(f) {...}	     | Declare a new test fixture named 'f' with        |
+|		     	     | additional data structure	                |
++----------------------------+--------------------------------------------------+
+| SETUP_F(f, s) {...}	     | Define setup function for the fixture            |
++----------------------------+--------------------------------------------------+
+| TEARDOWN_F(f, t) {...}     | Define teardown function for the fixture         |
++----------------------------+--------------------------------------------------+
+| INIT_F(f, s, t) {...}      | Declare the setup and tear down functions for the|
+|			     | fixture						|
++----------------------------+--------------------------------------------------+
+| TEST_F(s, f, n) {...}      | Define a test named 's.n' operating in fixture f	|
++----------------------------+--------------------------------------------------+
+| ADD_TEST(n)		     | Add a test previously declared with TEST or	|
+| 			     | TEST_F to the default handle.  	   		|
++----------------------------+--------------------------------------------------+
+| ADD_LOOP_TEST(n, from, to) | Add a test to be executed repeatedly with a range|
+| 		   	     | of values [from,to] to the implicit variable _i	|
++----------------------------+--------------------------------------------------+
+| DEL_TEST(n)		     | Remove a test previously added with ADD_TEST	|
++----------------------------+--------------------------------------------------+
+| KTF_ENTRY_PROBE(f, h)      | Define function entry probe for function f with  |
+| {...}              	     | handler function h. Must be used at global level.|
++----------------------------+--------------------------------------------------+
+| KTF_ENTRY_PROBE_RETURN(r)  | Return from probed function with return value r. |
+|  			     | Must be called within KTF_ENTRY_PROBE().         |
++----------------------------+--------------------------------------------------+
+| KTF_REGISTER_ENTRY_PROBE   | Enable probe on entry to kernel function f	|
+| (f, h)                     | with handler h.                                  |
++----------------------------+--------------------------------------------------+
+| KTF_UNREGISTER_ENTRY_PROBE | Disable probe on entry to kernel function f      |
+| (f, h)		     | which used handler h.                            |
++----------------------------+--------------------------------------------------+
+| KTF_RETURN_PROBE(f, h)     | Define function return probe for function f with |
+| {..}			     | handler h.  Must be used at a global level.      |
++----------------------------+--------------------------------------------------+
+| KTF_RETURN_VALUE()         | Retrieve return value in body of return probe.   |
++----------------------------+--------------------------------------------------+
+| KTF_REGISTER_RETURN_PROBE  | Enable probe for return of function f with       |
+| (f, h)                     | handler h.                                       |
++----------------------------+--------------------------------------------------+
+| KTF_UNREGISTER_RETURN_PROBE| Disable probe for return of function f and       |
+| (f, h)                     | handler h.                                       |
++----------------------------+--------------------------------------------------+
+| ktf_cov_enable(m, flags)   | Enable coverage analytics for module m.          |
+|			     | Flag must be either 0 or KTF_COV_OPT_MEM.        |
++----------------------------+--------------------------------------------------+
+| ktf_cov_disable(m)	     | Disable coverage analytics for module m.         |
++----------------------------+--------------------------------------------------+
+| KTF_THREAD_INIT(name, t)   | Initialize thread name, struct ktf_thread * t.   |
++----------------------------+--------------------------------------------------+
+| KTF_THREAD_RUN(t)          | Run initialized struct ktf_thread * t.           |
++----------------------------+--------------------------------------------------+
+| KTF_THREAD_STOP(t)         | Stop thread via kthread_stop()                   |
++----------------------------+--------------------------------------------------+
+| KTF_THREAD_WAIT_STARTED(t) | Wait for start of struct ktf_thread * t.         |
++----------------------------+--------------------------------------------------+
+| KTF_THREAD_WAIT_COMPLETED  | Wait for completion of struct ktf_thread * t.    |
+| (t)                        |                                                  |
++----------------------------+--------------------------------------------------+
+| HTEST(s, n) { ... }        | Declares a hybrid test. A correspondingly named  |
+| (NB! User mode only!)      | test must be declared using TEST() from kernel   |
+|                            | space for the hybrid test to be executed.        |
++----------------------------+--------------------------------------------------+
+| KTF_USERDATA(self, type, d)| Declare/get a pointer to user/kernel aux.data    |
+| (NB! both kernel and       | for a test that declares such extra data. Used   |
+| user space!)               | for hybrid tests.                                |
++----------------------------+--------------------------------------------------+
+
+The ``KTF_INIT()`` macro must be called at a global level as it just
+defines a variable ``__test_handle`` which is referred to, and which existence
+is assumed to continue until the call to KTF_CLEANUP(), typically done in
+the ``__exit`` function of the test module.
+
+
+
+Assertions
+**********
+
+Below is example documentation for some of the available assertion macros.
+For a full overview, see ``kernel/ktf.h``
+
+.. kernel-doc:: kernel/ktf.h
+   :internal:
-- 
git-series 0.9.1
