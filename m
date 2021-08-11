Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E663E911A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhHKMbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 08:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237702AbhHKMav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 08:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628685020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhI+Jpw21wRyiXw1xpRGiUEgUtxFY2GpZUIIqD4wt6g=;
        b=XAEKCwSS6W4YkoWy1UfHmle0GTxAhxWKRqnBiXC/46B1lO+YgBV//wgoq5i+qs/0mMvQUa
        nvGmM686yGEnfzhYcac4+YxAcEgxq4P+MhcaghaFPN21DcdUFvecaXvy3XBqJ4PDLm6xnD
        rZIEysO071dXftIt0Wph1c54Pn/SREM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-UxsCJig1M7Gd3ch-y8Eh3A-1; Wed, 11 Aug 2021 08:30:17 -0400
X-MC-Unique: UxsCJig1M7Gd3ch-y8Eh3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E168100808D;
        Wed, 11 Aug 2021 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943965D9C6;
        Wed, 11 Aug 2021 12:29:59 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 4/6] scripts/gdb: rework lx-symbols gdb script
Date:   Wed, 11 Aug 2021 15:29:25 +0300
Message-Id: <20210811122927.900604-5-mlevitsk@redhat.com>
In-Reply-To: <20210811122927.900604-1-mlevitsk@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix several issues that are present in lx-symbols script:

* Track module unloads by placing another software breakpoint at
  'free_module'
  (force uninline this symbol just in case), and use remove-symbol-file
  gdb command to unload the symobls of the module that is unloading.

  That gives the gdb a chance to mark all software breakpoints from
  this module as pending again.
  Also remove the module from the 'known' module list once it is unloaded.

* Since we now track module unload, we don't need to reload all
  symbols anymore when 'known' module loaded again
  (that can't happen anymore).
  This allows reloading a module in the debugged kernel to finish
  much faster, while lx-symbols tracks module loads and unloads.

* Disable/enable all gdb breakpoints on both module load and unload
  breakpoint hits, and not only in 'load_all_symbols' as was done before.
  (load_all_symbols is no longer called on breakpoint hit)
  That allows gdb to avoid getting confused about the state of the
  (now two) internal breakpoints we place.
  Otherwise it will leave them in the kernel code segment, when
  continuing which triggers a guest kernel panic as soon as it skips
  over the 'int3' instruction and executes the garbage tail of the optcode
  on which the breakpoint was placed.

* Block SIGINT while the script is running as this seems to crash gdb

* Add a basic check that kernel is already loaded into the guest memory
  to avoid confusing errors.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 kernel/module.c              |   8 +-
 scripts/gdb/linux/symbols.py | 203 +++++++++++++++++++++++------------
 2 files changed, 143 insertions(+), 68 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index ed13917ea5f3..242bd4bb0b55 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -906,8 +906,12 @@ int module_refcount(struct module *mod)
 }
 EXPORT_SYMBOL(module_refcount);
 
-/* This exists whether we can unload or not */
-static void free_module(struct module *mod);
+/* This exists whether we can unload or not
+ * Keep it uninlined to provide a reliable breakpoint target,
+ * e.g. for the gdb helper command 'lx-symbols'.
+ */
+
+static noinline void free_module(struct module *mod);
 
 SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 		unsigned int, flags)
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 08d264ac328b..78e278fb4bad 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -14,45 +14,23 @@
 import gdb
 import os
 import re
+import signal
 
 from linux import modules, utils
 
 
 if hasattr(gdb, 'Breakpoint'):
-    class LoadModuleBreakpoint(gdb.Breakpoint):
-        def __init__(self, spec, gdb_command):
-            super(LoadModuleBreakpoint, self).__init__(spec, internal=True)
+
+    class BreakpointWrapper(gdb.Breakpoint):
+        def __init__(self, callback, **kwargs):
+            super(BreakpointWrapper, self).__init__(internal=True, **kwargs)
             self.silent = True
-            self.gdb_command = gdb_command
+            self.callback = callback
 
         def stop(self):
-            module = gdb.parse_and_eval("mod")
-            module_name = module['name'].string()
-            cmd = self.gdb_command
-
-            # enforce update if object file is not found
-            cmd.module_files_updated = False
-
-            # Disable pagination while reporting symbol (re-)loading.
-            # The console input is blocked in this context so that we would
-            # get stuck waiting for the user to acknowledge paged output.
-            show_pagination = gdb.execute("show pagination", to_string=True)
-            pagination = show_pagination.endswith("on.\n")
-            gdb.execute("set pagination off")
-
-            if module_name in cmd.loaded_modules:
-                gdb.write("refreshing all symbols to reload module "
-                          "'{0}'\n".format(module_name))
-                cmd.load_all_symbols()
-            else:
-                cmd.load_module_symbols(module)
-
-            # restore pagination state
-            gdb.execute("set pagination %s" % ("on" if pagination else "off"))
-
+            self.callback()
             return False
 
-
 class LxSymbols(gdb.Command):
     """(Re-)load symbols of Linux kernel and currently loaded modules.
 
@@ -61,15 +39,52 @@ are scanned recursively, starting in the same directory. Optionally, the module
 search path can be extended by a space separated list of paths passed to the
 lx-symbols command."""
 
-    module_paths = []
-    module_files = []
-    module_files_updated = False
-    loaded_modules = []
-    breakpoint = None
-
     def __init__(self):
         super(LxSymbols, self).__init__("lx-symbols", gdb.COMMAND_FILES,
                                         gdb.COMPLETE_FILENAME)
+        self.module_paths = []
+        self.module_files = []
+        self.module_files_updated = False
+        self.loaded_modules = {}
+        self.internal_breakpoints = []
+
+    # prepare GDB for loading/unloading a module
+    def _prepare_for_module_load_unload(self):
+
+        self.blocked_sigint = False
+
+        # block SIGINT during execution to avoid gdb crash
+        sigmask = signal.pthread_sigmask(signal.SIG_BLOCK, [])
+        if not signal.SIGINT in sigmask:
+            self.blocked_sigint = True
+            signal.pthread_sigmask(signal.SIG_BLOCK, {signal.SIGINT})
+
+        # disable all breakpoints to workaround a GDB bug where it would
+        # not correctly resume from an internal breakpoint we placed
+        # in do_module_init/free_module (it leaves the int3
+        self.saved_breakpoints = []
+        if hasattr(gdb, 'breakpoints') and not gdb.breakpoints() is None:
+            for bp in gdb.breakpoints():
+                self.saved_breakpoints.append({'breakpoint': bp, 'enabled': bp.enabled})
+                bp.enabled = False
+
+        # disable pagination to avoid asking user for continue
+        show_pagination = gdb.execute("show pagination", to_string=True)
+        self.saved_pagination = show_pagination.endswith("on.\n")
+        gdb.execute("set pagination off")
+
+    def _unprepare_for_module_load_unload(self):
+        # restore breakpoint state
+        for breakpoint in self.saved_breakpoints:
+            breakpoint['breakpoint'].enabled = breakpoint['enabled']
+
+        # restore pagination state
+        gdb.execute("set pagination %s" % ("on" if self.saved_pagination else "off"))
+
+        # unblock SIGINT
+        if self.blocked_sigint:
+            sigmask = signal.pthread_sigmask(signal.SIG_UNBLOCK, {signal.SIGINT})
+            self.blocked_sigint = False
 
     def _update_module_files(self):
         self.module_files = []
@@ -107,7 +122,7 @@ lx-symbols command."""
                     name=section_name, addr=str(address)))
         return "".join(args)
 
-    def load_module_symbols(self, module):
+    def _do_load_module_symbols(self, module):
         module_name = module['name'].string()
         module_addr = str(module['core_layout']['base']).split()[0]
 
@@ -130,56 +145,112 @@ lx-symbols command."""
                 addr=module_addr,
                 sections=self._section_arguments(module))
             gdb.execute(cmdline, to_string=True)
-            if module_name not in self.loaded_modules:
-                self.loaded_modules.append(module_name)
+
+            self.loaded_modules[module_name] = {"module_file": module_file,
+                                                "module_addr": module_addr}
         else:
             gdb.write("no module object found for '{0}'\n".format(module_name))
 
+
+    def load_module_symbols(self):
+        module = gdb.parse_and_eval("mod")
+
+                # module already loaded, false alarm
+        # can happen if 'do_init_module' breakpoint is hit multiple times
+        # due to interrupts
+        module_name = module['name'].string()
+        if module_name in self.loaded_modules:
+            gdb.write("spurious module load breakpoint\n")
+            return
+
+        # enforce update if object file is not found
+        self.module_files_updated = False
+        self._prepare_for_module_load_unload()
+        try:
+            self._do_load_module_symbols(module)
+        finally:
+            self._unprepare_for_module_load_unload()
+
+
+    def unload_module_symbols(self):
+        module = gdb.parse_and_eval("mod")
+        module_name = module['name'].string()
+
+        # module already unloaded, false alarm
+        # can happen if 'free_module' breakpoint is hit multiple times
+        # due to interrupts
+        if not module_name in self.loaded_modules:
+            gdb.write("spurious module unload breakpoint\n")
+            return
+
+        module_file = self.loaded_modules[module_name]["module_file"]
+        module_addr = self.loaded_modules[module_name]["module_addr"]
+
+        self._prepare_for_module_load_unload()
+        try:
+            gdb.write("unloading @{addr}: {filename}\n".format(
+                addr=module_addr, filename=module_file))
+            cmdline = "remove-symbol-file {filename}".format(
+                filename=module_file)
+            gdb.execute(cmdline, to_string=True)
+            del self.loaded_modules[module_name]
+
+        finally:
+            self._unprepare_for_module_load_unload()
+
     def load_all_symbols(self):
         gdb.write("loading vmlinux\n")
 
-        # Dropping symbols will disable all breakpoints. So save their states
-        # and restore them afterward.
-        saved_states = []
-        if hasattr(gdb, 'breakpoints') and not gdb.breakpoints() is None:
-            for bp in gdb.breakpoints():
-                saved_states.append({'breakpoint': bp, 'enabled': bp.enabled})
-
-        # drop all current symbols and reload vmlinux
-        orig_vmlinux = 'vmlinux'
-        for obj in gdb.objfiles():
-            if obj.filename.endswith('vmlinux'):
-                orig_vmlinux = obj.filename
-        gdb.execute("symbol-file", to_string=True)
-        gdb.execute("symbol-file {0}".format(orig_vmlinux))
-
-        self.loaded_modules = []
-        module_list = modules.module_list()
-        if not module_list:
-            gdb.write("no modules found\n")
-        else:
-            [self.load_module_symbols(module) for module in module_list]
+        self._prepare_for_module_load_unload()
+        try:
+            # drop all current symbols and reload vmlinux
+            orig_vmlinux = 'vmlinux'
+            for obj in gdb.objfiles():
+                if obj.filename.endswith('vmlinux'):
+                    orig_vmlinux = obj.filename
+            gdb.execute("symbol-file", to_string=True)
+            gdb.execute("symbol-file {0}".format(orig_vmlinux))
+            self.loaded_modules = {}
+            module_list = modules.module_list()
+            if not module_list:
+                gdb.write("no modules found\n")
+            else:
+                [self._do_load_module_symbols(module) for module in module_list]
+        finally:
+            self._unprepare_for_module_load_unload()
 
-        for saved_state in saved_states:
-            saved_state['breakpoint'].enabled = saved_state['enabled']
+        self._unprepare_for_module_load_unload()
 
     def invoke(self, arg, from_tty):
         self.module_paths = [os.path.abspath(os.path.expanduser(p))
                              for p in arg.split()]
         self.module_paths.append(os.getcwd())
 
+        try:
+            gdb.parse_and_eval("*start_kernel").fetch_lazy()
+        except gdb.MemoryError:
+            gdb.write("Error: Kernel is not yet loaded\n")
+            return
+
         # enforce update
         self.module_files = []
         self.module_files_updated = False
 
+        for bp in self.internal_breakpoints:
+            bp.delete()
+        self.internal_breakpoints = []
+
         self.load_all_symbols()
 
         if hasattr(gdb, 'Breakpoint'):
-            if self.breakpoint is not None:
-                self.breakpoint.delete()
-                self.breakpoint = None
-            self.breakpoint = LoadModuleBreakpoint(
-                "kernel/module.c:do_init_module", self)
+            self.internal_breakpoints.append(
+                BreakpointWrapper(self.load_module_symbols,
+                                  spec="kernel/module.c:do_init_module",
+                                  ))
+            self.internal_breakpoints.append(
+                BreakpointWrapper(self.unload_module_symbols,
+                                  spec="kernel/module.c:free_module",
+                                  ))
         else:
             gdb.write("Note: symbol update on module loading not supported "
                       "with this gdb version\n")
-- 
2.26.3

