Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B58AF6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfHMGLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfHMGLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68xaE022057;
        Tue, 13 Aug 2019 06:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=HhMcyroqMij2d5Lg82WAj2ypfByRL1QVurPA9HxkD10=;
 b=evEJsYytDvz7TszRj3tKgr0f8rPrOK8GLUt+racWZSc9xGskbSd61/F+PskkMlEoos2x
 mS0Uq1Y59M02yvsarvALYv3o0gRVn6SVUp3GWvptZ22sT0kE9Zw4WqSk4y6f9XhWfTDY
 Y01ew73D+sh/bCIu+igf7SKNEHCUqs8o22/6akImSyPqp1VHsxuOrAuFJUwRxGWG5WDA
 EK4Zz7mkjXGU6PICiS2uXstF7iiG5uBLEZjDUDR+LNlDc5kZ/Figfm8SRpm6unAfRuLS
 xWWW7koG50Rbt+SBNd6Iy665SBvPhFt2eGeYFQHHnd8eQjhwF7NmLpdal/relVp0URfD BQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=HhMcyroqMij2d5Lg82WAj2ypfByRL1QVurPA9HxkD10=;
 b=pd2ldQlK7kezzlqOr6fZolDPz0faMs3pLmMHzqqXPzZ6Nre82W5hazHH4zo4MIKK3C8R
 Dzhrx9jEplMlSENGA1sbohJ01q8FwWCe1MD1gov1yd+LRWDz6lvMtpoHD6DUXeiFPnQO
 fLwo4njOtLTTYlrB036zledWx8Oi6OXfpN1+snxLuHgnKk0D0kyDJnmvhUoc+QvO64Dq
 B3cSQp2lG7NDK6/okI7DqY/itFQdBgsnJaKPH50pWydmUUYJCoT0mDhhfTLD6UA/9k+n
 ZX0koUsBIijOkgXT9h6wumr+i9MlPepjvOnEcZRfPSJ956VVnAWWhoqF6D9CIbfjstvn Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjqbvkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67ShE157015;
        Tue, 13 Aug 2019 06:11:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u9nrenm67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:27 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6BPgd026354;
        Tue, 13 Aug 2019 06:11:25 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:25 -0700
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
Subject: [RFC 09/19] ktf: resolve: A helper utility to aid in exposing private kernel symbols to KTF tests.
Date:   Tue, 13 Aug 2019 08:09:24 +0200
Message-Id: <09d79897772dd370a61967b03e83fa4b8663698b.1565676440.git-series.knut.omang@oracle.com>
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

Takes an input file foo.txt with a list of symbols on the form:

#module foo
#header foo.h
private_foo_symbol_1
private_foo_symbol_2

and creates usable definitions to access these (requires CONFIG_KALLSYMS_ALL).
This is useful to be able to easily and cleanly test internal interfaces of a module.
Examples follows in the selftests later in the series.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/scripts/resolve | 188 +++++++++++++++++++++-
 1 file changed, 188 insertions(+)
 create mode 100755 tools/testing/selftests/ktf/scripts/resolve

diff --git a/tools/testing/selftests/ktf/scripts/resolve b/tools/testing/selftests/ktf/scripts/resolve
new file mode 100755
index 0000000..74005f7
--- /dev/null
+++ b/tools/testing/selftests/ktf/scripts/resolve
@@ -0,0 +1,188 @@
+#!/usr/bin/python
+
+# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+#    Author: Knut Omang <knut.omang@oracle.com>
+#
+# SPDX-License-Identifier: GPL-2.0
+#
+# A script to generate code and header definitions for
+# module and kernel symbols not directly exposed to KTF.
+# (See the documentation for KTF for details)
+#
+
+import os, sys, re, shutil, string, ConfigParser
+
+def usage():
+    print "Usage: resolve symbolfile outputfile"
+    exit(0)
+
+class FuncInfo:
+    def __init__(self, sym, re_sym, re_decl):
+        self.symbol = sym
+        self.re_sym = re_sym
+        self.re_decl = re_decl
+
+    def __repr__(self):
+        return "FuncInfo: [%s: %s]" % (self.symbol, self.re_decl)
+
+class Module:
+    def __init__(self, name, header):
+        self.cur_header = header
+        self.prefix = "Z"
+        self.name = name
+        self.symbols = {}  # Input:  headerfile -> symbol list
+        self.func_def = []  # FuncInfo list
+        self.debug = False
+        all_modules.append(self)
+
+    def log(self, str):
+        if self.debug:
+            print str
+
+    def SetHeader(self, header):
+        self.cur_header = header
+
+    def AddSymbol(self, sym):
+        try:
+            h = self.symbols[self.cur_header]
+            h.append(sym)
+        except:
+            self.symbols[self.cur_header] = [sym]
+
+    # Open along include path:
+    def Open(self, filename):
+        for p in includepath:
+            try:
+                f = os.path.join(p, filename)
+                self.log(" -- trying " + f)
+                header = open(f,'r')
+                return header
+            except:
+                continue
+        sys.stderr.write(" ** unable to open \"%s\"\n" % filename)
+        return None
+
+    # Parse the relevant header files for function defs:
+    def ParseDefs(self):
+        for hf in self.symbols.keys():
+            self.log(" ** Parsing %s:" % hf)
+            header = self.Open(hf)
+            if header == None:
+                return
+            content = header.read()
+            symbols = self.symbols[hf]
+            types = r"(extern|u8|u16|u32|u64|int|long|size_t|off_t|loff_t|void|struct|union\s)(.*[\*\s]"
+            funor = ")(" + "|".join(symbols) + r")(\([^\)]+\);)$"
+            tt = types + funor
+            s = re.compile(tt, re.MULTILINE)
+            miter = s.finditer(content)
+            s_count = 0
+            for m in miter:
+                sym = m.group(3)
+                re_name = "_".join([self.prefix, sym])
+                re_decl = "%s%s(*%s)%s" % (m.group(1), m.group(2), re_name, m.group(4))
+                self.func_def.append(FuncInfo(sym, re_name, re_decl))
+                s_count = s_count + 1
+
+            if s_count != len(symbols):
+                print " ** Warning: File %s: Found %d definitions from %d symbols!" % \
+                    (hf, s_count, len(symbols))
+                print " ** - please check/fix output manually!"
+
+    # Output functions:
+    def write_funcs(self, file):
+        for fi in self.func_def:
+            file.write("\t%s\n"% fi.re_decl)
+
+    def write_defines(self, file):
+        for fi in self.func_def:
+            file.write("#define %s ktf_syms.%s\n" % (fi.symbol, fi.re_sym))
+
+    def write_resolve_calls(self, file):
+        for fi in self.func_def:
+            file.write("\tktf_resolve_symbol(%s, %s);\n" % (self.name, fi.symbol))
+
+usage_h = False
+my_argv = []
+includepath = [""]
+
+for arg in sys.argv[1:]:
+    if arg == "-h":
+        usage_h = True
+        continue
+    incl = re.match(r"-I([^\s]+)", arg)
+    if incl != None:
+        includepath.append(incl.group(1))
+        continue
+    genopt = re.match(r"-([^\s]+)", arg)
+    if genopt != None:
+        # Silently ignore other cc options as we accept cc-flags-y:
+        #
+        continue
+    my_argv.append(arg)
+
+# Main program:
+
+if len(my_argv) != 2 or usage_h:
+    usage()
+
+symfile = my_argv[0]
+outputfile = my_argv[1]
+
+all_modules = []
+module = Module("kernel", None)  # Default, at the top of the file is the main kernel symbols
+header = None  # A header directive is required before any symbols
+
+try:
+    file = open(symfile, 'r')
+except:
+    print "Unable to open config file \"%s\"" % symfile
+    exit(1)
+for line in file:
+    match = re.match(r"^#(\w+) ([\w\.]+)\s*$", line)
+    if match != None:
+        cmd = match.group(1)
+        value = match.group(2)
+        if cmd == "module":
+            module = Module(value, header)
+        elif cmd == "header":
+            header = value
+            module.SetHeader(header)
+        else:
+            raise ResolveError("Unknown directive \"%s\"" % cmd)
+        #print "%s set to %s" % (cmd, value)
+        continue
+    match = re.match(r"\s*(\w+)\s*", line)
+    if match != None:
+        s = match.group(1)
+        module.AddSymbol(s)
+
+for m in all_modules:
+    m.ParseDefs()
+
+try:
+    output = open(outputfile, "w")
+except:
+    print "Failed to open output header file \"%s\"" % outputfile
+output.write('#ifndef _KTF_RESOLVE_H\n#define _KTF_RESOLVE_H\n')
+output.write('#include "ktf.h"\n\nstruct ktf_syms {\n')
+
+for m in all_modules:
+    m.write_funcs(output)
+
+output.write('};\n\n')
+
+for m in all_modules:
+    m.write_defines(output)
+
+output.write('\n\nextern struct ktf_syms ktf_syms;\n')
+output.write('\nint ktf_resolve_symbols(void);\n#ifndef KTF_CLIENT\n')
+output.write('struct ktf_syms ktf_syms;\n\n')
+
+output.write('\nint ktf_resolve_symbols(void)\n{\n')
+
+for m in all_modules:
+    m.write_resolve_calls(output)
+
+output.write('\treturn 0;\n}\n\n#endif /* !KTF_CLIENT */\n#endif /* _KTF_RESOLVE_H */ \n')
+output.close()
-- 
git-series 0.9.1
