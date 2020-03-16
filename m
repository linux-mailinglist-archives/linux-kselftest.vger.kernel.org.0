Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A911873E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Mar 2020 21:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbgCPUVq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 16:21:46 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36301 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbgCPUVp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 16:21:45 -0400
Received: by mail-pg1-f202.google.com with SMTP id b130so12879355pga.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Mar 2020 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0dKXpM+vAToFQ99KFoY4s/h1UvCiGXVGJzVOlRPgN/w=;
        b=lL1UaDJ33tqQdzKUxp7HqRoiLyuZO479lvU6K9jUmKLpg0o1p4LSgewSvJ2wJzWsYK
         RVeji6SAfZdkg8w/OOlb/aA5GppJiCyzOIuTDimNye627x0kRPDMO/sVk0Ka/uQMLYGI
         V8sbQrXBatkbxDemqrL+u4d1aTYPkVNi8PM7Ahm8XZDhy4T2IXt04dCDAOmnJclbME92
         z2eXHlgn6AfKzhPa5Pujnaja7PShVvF7S0L6WAPUX6EpwT9ZudwrRuaAoneqKLhbXouO
         bXHeb6ZYoEZZbQUJn2C7DSsftxZAP7oUeRO9KtsztW9zQ+fmMas08bfd9uzqAZqq1g10
         N8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0dKXpM+vAToFQ99KFoY4s/h1UvCiGXVGJzVOlRPgN/w=;
        b=Nr48Kx3l7hf566JQoioYdmlLmCdfk3n7j59h3gCPidKW63FLmG1VgpG7CbzVhqPsaF
         iN4dxdJnSXcJDG/DHZ2+gtaeEmVLqEEP6AW+BRLr0W6M7k7Q8Y8yrJxae6F4ektYyIJd
         Ib+DKQs9L7FLQ3nonCmmBEMqwmRTIitHCbRNUDDhdZZ1EMpU/hmmvptnzI7jKfUzD7aA
         Qwj0EcTGtYwffMi8HxiML9gRziavUFL4OifqofY46dkbVFTfOLcEhcMYMTYMs2bNg0U1
         lAC21qp4JsS6YKe1CdFAtJ+A0yBk/XNyiojPWNXhyxuNXfI8BAvSSNVoFWcaMwKm06h6
         U64w==
X-Gm-Message-State: ANhLgQ1uolZfLU4VpzUK3s1TxIlR9WZZYMyao+Yh5JetQV1ppLeDDqG9
        qfj11dityZ2yXjKkMlPE+pSVFKP8gIwdxMTm
X-Google-Smtp-Source: ADFU+vsklmZkx4fIL8aNLf15/1C/GMKjVqewxq+sntb7vgeAeK+izs7ZtDWLg1kkj0HyrUNTJ7JSPV82/CJAvhX0
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr1254907pjb.153.1584390103472;
 Mon, 16 Mar 2020 13:21:43 -0700 (PDT)
Date:   Mon, 16 Mar 2020 13:21:24 -0700
Message-Id: <20200316202125.15852-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 1/2] kunit: kunit_parser: make parser more robust
From:   Heidi Fahim <heidifahim@google.com>
To:     shuah@kernel.org, brendanhiggins@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Cc:     Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, kunit_parser did not properly handle kunit TAP output that
- had any prefixes (generated from different configs e.g.
CONFIG_PRINTK_TIME)
- had unrelated kernel output mixed in the middle of
it, which has shown up when testing with allyesconfig
To remove prefixes, the parser looks for the first line that includes
TAP output, "TAP version 14".  It then determines the length of the
string before this sequence, and strips that number of characters off
the beginning of the following lines until the last KUnit output line is
reached.
These fixes have been tested with additional tests in the
KUnitParseTest and their associated logs have also been added.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
Changelog
 v3:
 - Addressing Shuah's git apply issues with whitespaces. Marked all
   files in test_data as binaries in new kunit/ .gitattributes file. The
   irregular whitespaces here are necessary as they are used for testing
   the KUnit parser.
 - Important: please note that now git apply works, however the .log
   files in /test_data/ may get marked as Untracked files. These should
   be included in the commit as they are required for
   kunit_tool_test.py.

tools/testing/kunit/.gitattributes            |   1 +
 tools/testing/kunit/kunit_parser.py           |  40 +++++-----
 tools/testing/kunit/kunit_tool_test.py        |  69 ++++++++++++++++++
 .../test_data/test_config_printk_time.log     | Bin 0 -> 1584 bytes
 .../test_data/test_interrupted_tap_output.log | Bin 0 -> 1982 bytes
 .../test_data/test_kernel_panic_interrupt.log | Bin 0 -> 1321 bytes
 .../test_data/test_multiple_prefixes.log      | Bin 0 -> 1832 bytes
 ..._output_with_prefix_isolated_correctly.log | Bin 0 -> 1655 bytes
 .../kunit/test_data/test_pound_no_prefix.log  | Bin 0 -> 1193 bytes
 .../kunit/test_data/test_pound_sign.log       | Bin 0 -> 1655 bytes
 10 files changed, 90 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/kunit/.gitattributes
 create mode 100644 tools/testing/kunit/test_data/test_config_printk_time.log
 create mode 100644 tools/testing/kunit/test_data/test_interrupted_tap_output.log
 create mode 100644 tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
 create mode 100644 tools/testing/kunit/test_data/test_multiple_prefixes.log
 create mode 100644 tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
 create mode 100644 tools/testing/kunit/test_data/test_pound_no_prefix.log
 create mode 100644 tools/testing/kunit/test_data/test_pound_sign.log

diff --git a/tools/testing/kunit/.gitattributes b/tools/testing/kunit/.gitattributes
new file mode 100644
index 000000000000..5b7da1fc3b8f
--- /dev/null
+++ b/tools/testing/kunit/.gitattributes
@@ -0,0 +1 @@
+test_data/* binary
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 4ffbae0f6732..adf86747b07f 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -46,19 +46,21 @@ class TestStatus(Enum):
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
 
-kunit_start_re = re.compile(r'^TAP version [0-9]+$')
-kunit_end_re = re.compile('List of all partitions:')
+kunit_start_re = re.compile(r'TAP version [0-9]+$')
+kunit_end_re = re.compile('(List of all partitions:|'
+			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def isolate_kunit_output(kernel_output):
 	started = False
 	for line in kernel_output:
-		if kunit_start_re.match(line):
+		if kunit_start_re.search(line):
+			prefix_len = len(line.split('TAP version')[0])
 			started = True
-			yield line
-		elif kunit_end_re.match(line):
+			yield line[prefix_len:] if prefix_len > 0 else line
+		elif kunit_end_re.search(line):
 			break
 		elif started:
-			yield line
+			yield line[prefix_len:] if prefix_len > 0 else line
 
 def raw_output(kernel_output):
 	for line in kernel_output:
@@ -108,18 +110,16 @@ OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
 
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
 
-def parse_ok_not_ok_test_case(lines: List[str],
-			      test_case: TestCase,
-			      expecting_test_case: bool) -> bool:
+def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	save_non_diagnositic(lines, test_case)
 	if not lines:
-		if expecting_test_case:
-			test_case.status = TestStatus.TEST_CRASHED
-			return True
-		else:
-			return False
+		test_case.status = TestStatus.TEST_CRASHED
+		return True
 	line = lines[0]
 	match = OK_NOT_OK_SUBTEST.match(line)
+	while not match and lines:
+		line = lines.pop(0)
+		match = OK_NOT_OK_SUBTEST.match(line)
 	if match:
 		test_case.log.append(lines.pop(0))
 		test_case.name = match.group(2)
@@ -150,12 +150,12 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-def parse_test_case(lines: List[str], expecting_test_case: bool) -> TestCase:
+def parse_test_case(lines: List[str]) -> TestCase:
 	test_case = TestCase()
 	save_non_diagnositic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
 		pass
-	if parse_ok_not_ok_test_case(lines, test_case, expecting_test_case):
+	if parse_ok_not_ok_test_case(lines, test_case):
 		return test_case
 	else:
 		return None
@@ -234,11 +234,11 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
 	expected_test_case_num = parse_subtest_plan(lines)
 	if not expected_test_case_num:
 		return None
-	test_case = parse_test_case(lines, expected_test_case_num > 0)
-	expected_test_case_num -= 1
-	while test_case:
+	while expected_test_case_num > 0:
+		test_case = parse_test_case(lines)
+		if not test_case:
+			break
 		test_suite.cases.append(test_case)
-		test_case = parse_test_case(lines, expected_test_case_num > 0)
 		expected_test_case_num -= 1
 	if parse_ok_not_ok_test_suite(lines, test_suite):
 		test_suite.status = bubble_up_test_case_errors(test_suite)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index cba97756ac4a..0efae697f396 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -108,6 +108,36 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 1 - example', result)
 		file.close()
 
+	def test_output_with_prefix_isolated_correctly(self):
+		log_path = get_absolute_path(
+			'test_data/test_pound_sign.log')
+		with open(log_path) as file:
+			result = kunit_parser.isolate_kunit_output(file.readlines())
+		self.assertContains('TAP version 14\n', result)
+		self.assertContains('	# Subtest: kunit-resource-test', result)
+		self.assertContains('	1..5', result)
+		self.assertContains('	ok 1 - kunit_resource_test_init_resources', result)
+		self.assertContains('	ok 2 - kunit_resource_test_alloc_resource', result)
+		self.assertContains('	ok 3 - kunit_resource_test_destroy_resource', result)
+		self.assertContains(' foo bar 	#', result)
+		self.assertContains('	ok 4 - kunit_resource_test_cleanup_resources', result)
+		self.assertContains('	ok 5 - kunit_resource_test_proper_free_ordering', result)
+		self.assertContains('ok 1 - kunit-resource-test', result)
+		self.assertContains(' foo bar 	# non-kunit output', result)
+		self.assertContains('	# Subtest: kunit-try-catch-test', result)
+		self.assertContains('	1..2', result)
+		self.assertContains('	ok 1 - kunit_test_try_catch_successful_try_no_catch',
+				    result)
+		self.assertContains('	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
+				    result)
+		self.assertContains('ok 2 - kunit-try-catch-test', result)
+		self.assertContains('	# Subtest: string-stream-test', result)
+		self.assertContains('	1..3', result)
+		self.assertContains('	ok 1 - string_stream_test_empty_on_creation', result)
+		self.assertContains('	ok 2 - string_stream_test_not_empty_after_add', result)
+		self.assertContains('	ok 3 - string_stream_test_get_string', result)
+		self.assertContains('ok 3 - string-stream-test', result)
+
 	def test_parse_successful_test_log(self):
 		all_passed_log = get_absolute_path(
 			'test_data/test_is_test_passed-all_passed.log')
@@ -150,6 +180,45 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		file.close()
 
+	def test_ignores_prefix_printk_time(self):
+		prefix_log = get_absolute_path(
+			'test_data/test_config_printk_time.log')
+		with open(prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_ignores_multiple_prefixes(self):
+		prefix_log = get_absolute_path(
+			'test_data/test_multiple_prefixes.log')
+		with open(prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_prefix_mixed_kernel_output(self):
+		mixed_prefix_log = get_absolute_path(
+			'test_data/test_interrupted_tap_output.log')
+		with open(mixed_prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_prefix_poundsign(self):
+		pound_log = get_absolute_path('test_data/test_pound_sign.log')
+		with open(pound_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_kernel_panic_end(self):
+		panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
+		with open(panic_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_pound_no_prefix(self):
+		pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
+		with open(pound_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
 class StrContains(str):
 	def __eq__(self, other):
 		return self in other
diff --git a/tools/testing/kunit/test_data/test_config_printk_time.log b/tools/testing/kunit/test_data/test_config_printk_time.log
new file mode 100644
index 0000000000000000000000000000000000000000..c02ca773946d641291e27d44d73174cc16a17d9d
GIT binary patch
literal 1584
zcmai!-)q}25XYapzv7@T8>=%piIdE*htV+@8zqo+FQEuUKBp$O&PeiF|Mxq^U79*h
zs}~FTKHvK#-5Pj_k(dcycTn5H_+1K`jH41^UFj&k12k$=V)kzR(%LGMQI*0Lz3ldK
z(|UBERmtX%TdJTig_lINlSTGXJWi5N;&CeAq44*ht=Y<8@I~~se}7%VU$m|u1M#%~
z_u>*(&4yk16m|^@L>3)2R$~+nPt4=dC^<Q#9mEiIy!_A0!0%%^9JwKKe1_!ANgvQ5
za&m^u*s-PdRd#xY)g>y^)CYDj<m3!oTdL8@+#*V{8S)+2_5(kz)f=@wX^ppSq?OnA
zXL~d5ySq5{*R_OI<X%O(Mr(8~Z%P>s4Rz;38qZzYxAj@0F+G)x&<*QwC<mG7ja-g$
z=Vo#pBmSVO&SpLtiaOlN4woI?RRF8nw~~z1Ea~}S46z~90oIV09j|iF%~sjTYYsIJ
zcXNOa54=0>yL`dCmh7*>d7vEleL$_OFG2z??d#nT<VA_Dbsj4oLrs}MMUC-biTo9C
zQ8DXNeUYDN4F)%+(3}wG4z4wt+mXVb@2eDU_wx)q9ce@EfM-o(c7`5IwBcvGd;fWH
zB|h}!ua~ze2w493mhu3(riw?Pdr&n$BDi5+Uhxp+@t2IIBN160M_W|mESqbwm?s!z
zh4n35o?QBsS9;ga4PYk5Vlm4Xyoon@JQFY%i4ODnu<1v5%!nk{s1K(6ON{kQZ3dVp
N(^Ef_;Eh)-{s9AX)U5yj

literal 0
HcmV?d00001

diff --git a/tools/testing/kunit/test_data/test_interrupted_tap_output.log b/tools/testing/kunit/test_data/test_interrupted_tap_output.log
new file mode 100644
index 0000000000000000000000000000000000000000..5c73fb3a1c6fd13a9b163a48d02eb33b0315a375
GIT binary patch
literal 1982
zcmah~-A~&v5PxQW#YsG{v8HoBDUo<!Ff=rT5CvWkvRvoVMoH|*c7W`!-#OVzNz;*+
zIG6kV?)&@*^sqjgGJ2k%Fo|+$2vRGnGla)n27@O+B^DV*pB~?98=)edhp<G)n=@Zj
z4lPKLkvhai=a8txajgr>ljtjZ9ZkNm*D-^a#H~OYwd7vmgtfWvPH*5DjZL(I!MOc*
zZy)C6f=sy((vk=QgI1SDV&H{a>VtlNvL)0h3?OLm{2!iseC^X(WV?{V9Y~5?%QdtM
zIog4Y$gt7XPHcL5F%RLE^7>OapbwB)g37@&>kq)-GO-S+e#?H_>cu=b6LN(iT%(IE
z9EjK+tP#FY+EC5piok8`;o%`XoL*g?pWgid?*fpdt@Pa)qRq63FzQiN<!C5Rnpdzy
zMPA7sM7SuICtCGDSc}HhM`|}*n#5HB`6p8}wbWo7Q1O$vqR%a3ceg$f7PGi%0E^OT
z>XhFU;Fujx0hFd>uD?GdFr`uyIxOliVuJ{_5EAR0Ab2aCJuu!;NtvNgWwEYgCwQ_0
zTo_%T;ob|bO;lI39l>Vje$e?_gW?S3S~$7dIVr=oxxGz$&43UKuUWV)r9^AvGUHyT
zbR+NLc$=Ae$lf?g)nbV>+HM|lWla-&5X(mFG+I>QfL<u_oso~ay!Jbyf%695WB~KR
zRa`4BiPF)U>cV<gJFrSS-rxoGu;C)w+O0n4ep7Uy{km<$ZIkaX{|oktb_M7dXj?%c
zj7xj~Hf-}<YlxE!ZAF_Ur%R#CBFJ?~JI844dO%6VsEulq{6eG9n^B3RfGBpbm6BAB
z5FY#_-`BSbIK9CQv`=XBmnv2IMFk65s_EzBS&w~b)1Tekhrr<G@;sz<ex`G}knD>n
zXo%pNY&qd~OaznuxX%J32egsIFp7>On;lIsh!W!}*xzdUxf3#N#|AKELpGbnGdc_w
rayVsh#3s_;p6f%~!%YmE#1iFNm430IoQg#U=CA6uosqXj&w%{_Pb*9~

literal 0
HcmV?d00001

diff --git a/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
new file mode 100644
index 0000000000000000000000000000000000000000..c045eee75f27fefaabf3ba073d9e282721c19a67
GIT binary patch
literal 1321
zcmai!-)q}25XYapzv7@T8=EuPiIdc@htV+@gAvHOmr#T(%c-%gGm^a2|NYK!=cfMA
z>c!%GpYPr2bUFYnwqR>U>mDkTX_rSJQCln&97^f=_n@?h3zfV(y!19gCs;;sRE~Fh
z9yd-|kfI=WNDY>d>CAD&%JMAv$R3yBXZE;aaLU{RNTZLub@;-D+P}Z<;IA?^Lk<3F
z`1k4>_H|65Tm*Sd0-jM8Ya^A{8b|K_ViAsvn1c^q$MgR@Z~1dhy~$3I!3;^2qwLWs
zaydgL6xd+%D!ZCtWub(wtDc=qIh=tjgOxHoHA-<biK07j943BwR&Sj3s5Q<so)k_#
z%=RW2hP%3q*R_OH_*sS9T1sVYS{J-EYV7P&8qZxixAj@0)&rFUm7Uh1RC*cjjan{h
zr)JVQdh}7EoUMF0m34b7JDhiTcLJ)cT*FawNs^8RW5oVcMymoUp)*Mu8Xee1OUfgH
zKi~He+?@v*972h;c3_ZPQVTR>wazu3v=`I;&EMZ_Kd}!({oCDL1PpdRzC|=Sw^-8b
z+mop1_P{R^a)MqDn)`6ES}@N@-#aQ1B*{jy?Iu)Sk{Q>)^{Cr>CuANCqrsX5Y`adk
qwDDsZtQl-rDBFjs-@L}KFqKO7uB5^OxfbyR^W-{?vuvZ$^4UKw_JoN5

literal 0
HcmV?d00001

diff --git a/tools/testing/kunit/test_data/test_multiple_prefixes.log b/tools/testing/kunit/test_data/test_multiple_prefixes.log
new file mode 100644
index 0000000000000000000000000000000000000000..bc48407dcc36c44665c7d2ac620e42e7caf98481
GIT binary patch
literal 1832
zcma)-UvJYe5Wt_ur#NXZAeQ2^O;;lEfQFC|XsWc0mua$G=h8(@e39+2<=b;^pet<7
z>X$ed-|znUF1Nr-OvFO)y1NZ;*XbR!wlaR3gC^ssM!0Qs!eTUPU1RZPcka2CRi>aO
zhYfl;?B%-m=s>HQ)u6Q0KxHZ~iCQPC;=OpBWgo=jT);!+??GF$k>S865wmgqc?G}F
zx{3^>^Vq4AQ@HBZY})6r?HHI?bktdmNf1WW(#a%?exxm=kPJNemnQ>n=ks3V#t730
zfipyUj~FA&B7}k+vD6>Mm`518MrFEo&ln9Qi$GdSEm~PxL`k+lzDt`}K!-U!vPREJ
z>usNC<@NomwVlS?I63rVC@E9rjw)TJH9A*zwG2W-gM5tjROQ|Ecw%+tKUzWP#(C`8
z9+w;$>p_nAQgHqgexPbz&CqNts&M-UoE&gNrm$&!FUd&FCOkLh7$b!80>hA(14osf
zFOMpsQzq0Z^uP<0Fn9)W%!Pk+k4egp%6Xs?xIdv))>k1wm&f>*1Z7pD>z&7j$7fd;
z&`@VQSR#K0TnsE?+A-*Nv<8EDQ)v#Ia|Nz9n#-EQ&#zZG-0bEucsj5Jr30Rko!J_C
zFv*(7%l7TZ<(YUFGjp-J$w9#C+n1aN-32u~%H4x%xtZaTZF<E&1s>zsWIhpz)oHRp
zH7$yBEtcmQCPig^52w*4yYfnJW3dA)#8fO7<&rn)T2B`O&PArfe`&vod48xXvQneo
XtMDf=)eE&A(fy<H-0mz`=aq`zHIoXT

literal 0
HcmV?d00001

diff --git a/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log b/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
new file mode 100644
index 0000000000000000000000000000000000000000..0f87cdabebb098a6a7132661ab482f273ac6ecfd
GIT binary patch
literal 1655
zcmah}O^?$s5IvV)F;XueHpOY1wnXB979k<fs!~}l)yi@lryDi#M7BdW|DJIJ-EKY>
zUt&$>z4`Rp106PFD@Nx5DwAt>j6tHdSSZ++G6)|)X^|8veY1b*ZG=v-jNzahZ|^*5
zoU$NALGF+lEFssq<A{~zdHS9`Eus(XY02P}yGM{lAGmk;#Jb!+KX2i;GB!sI;j;U8
zGKF28P$(C}u_l7RD2ug`D)7dhdpMg#JtH0=grLRqe|YZk=bSDkJA|B%AgOYc7w8aj
zF@j7fu)$^&3mGCL!oXxYM7tcJm4y<zt}e8L)kGuU%3!4o&x}$WO{!=;4&C6_ZG3$U
zR~3Lp9h@fzSi7q3kE}OgXPQ6?Cm%;gJnyD9xz4SfEV1x23%9kD%G#_hxHoES?L!>T
z!#;1vGe@mEEGa5G%tNVMXoCOLa#cI+1ob?ij}ql*<%^-L{c^W(-oo1ssIqbmN6jTs
zI(lD2SfA<uR-@xBUSy6IL!>=X@ICh{K7jT*(VDv<UtnG<_D60VU<UNepc2OAz5p9{
z`R)+1yim5WPL-r)b&*1ewRT_--3?GvRoX>$Nxmzil@FtHNd-~uU>hxI95MX*x{Kld
zEQ{dqiW@QuBw4jSYCP#6AvHL@{kXYd@4EE2+xr+8Y`=YpNr!H+Bqg;cQPG2gJBsB5
zX)&p2G+WMCU}P8^l$fXKTC&YLQbC#<*TA&5^gAcyv0EF!ip|+(m2Kz}CUU-Fux63;
jvVXaBGrY#ID3eNFT<I5^%auq5Fn?Y9aTY!rosj(j<eKLf

literal 0
HcmV?d00001

diff --git a/tools/testing/kunit/test_data/test_pound_no_prefix.log b/tools/testing/kunit/test_data/test_pound_no_prefix.log
new file mode 100644
index 0000000000000000000000000000000000000000..2ceb360be7d52cbee4b0a5a426456605ded7466e
GIT binary patch
literal 1193
zcmZ{kPmh~05XH~sQ;f8iR$Wq)glvk`L$y_<s#O&!-CnB7GG@r4fCt&8yL|f&c$ct$
z!UfCzz0vby254<%{4oPf#!-#%r_pip7tpA@#v%f%OhHWs2lO(mW!`&qpjFKPl$IK(
zOywm}>tt2D7x%05gScM{xU2jvXlo8~06vKbetq7-KeVnQ1IapqHy5z)axUjHICc!h
z79Dj~V?1m!kSrD{zvu`F#DS5Ij2xJ;_O#^!yFA0PXVMcK*wq=f;Nq7084V>7<jS(`
zAYGr4>Kc{l+DZE0Dm{a@mRhv3w1|>yf&57h5zMdrJeHXgFl6E}JD|?D-4NP~RK4wE
zt-QXS#kvf4IK?`q$)p@f={l{^xw5O}uxTjl2h}OyXR6LT(-nm7QOQ@Dgz*bcGuNCv
zXAtuXRWtLvI(ZI=3`pn%Y+Bz-GE%e5bB~?8zCs)FGALB(Iet}eyAO>vG{h_XFacqE
z{5B`*sm&ji^FSqVt3j)*uLdJ7i{K|gS=H!z=ds~=>*@j;>Wl|V<S&7*j71hj@Exte
zL2N3`R@f)F-e?XagWq5G8QhG+37%$pC>`)nb>?X3&cr$Q`SI<??WK4Z!S(JY0|C2l
zUoxJeYif9&-JNQ=>DZMAulOIpvz#v03lUqL#0ON%qPWsxdzE5bRMz)!!40$bN+0<y
xun|kK-IQBiB)ML01YC(!3x1}>Q%a<zMm-&}PAv6C<s<cQ__Ee&sK`$u{sZ*XjN1SJ

literal 0
HcmV?d00001

diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
new file mode 100644
index 0000000000000000000000000000000000000000..0f87cdabebb098a6a7132661ab482f273ac6ecfd
GIT binary patch
literal 1655
zcmah}O^?$s5IvV)F;XueHpOY1wnXB979k<fs!~}l)yi@lryDi#M7BdW|DJIJ-EKY>
zUt&$>z4`Rp106PFD@Nx5DwAt>j6tHdSSZ++G6)|)X^|8veY1b*ZG=v-jNzahZ|^*5
zoU$NALGF+lEFssq<A{~zdHS9`Eus(XY02P}yGM{lAGmk;#Jb!+KX2i;GB!sI;j;U8
zGKF28P$(C}u_l7RD2ug`D)7dhdpMg#JtH0=grLRqe|YZk=bSDkJA|B%AgOYc7w8aj
zF@j7fu)$^&3mGCL!oXxYM7tcJm4y<zt}e8L)kGuU%3!4o&x}$WO{!=;4&C6_ZG3$U
zR~3Lp9h@fzSi7q3kE}OgXPQ6?Cm%;gJnyD9xz4SfEV1x23%9kD%G#_hxHoES?L!>T
z!#;1vGe@mEEGa5G%tNVMXoCOLa#cI+1ob?ij}ql*<%^-L{c^W(-oo1ssIqbmN6jTs
zI(lD2SfA<uR-@xBUSy6IL!>=X@ICh{K7jT*(VDv<UtnG<_D60VU<UNepc2OAz5p9{
z`R)+1yim5WPL-r)b&*1ewRT_--3?GvRoX>$Nxmzil@FtHNd-~uU>hxI95MX*x{Kld
zEQ{dqiW@QuBw4jSYCP#6AvHL@{kXYd@4EE2+xr+8Y`=YpNr!H+Bqg;cQPG2gJBsB5
zX)&p2G+WMCU}P8^l$fXKTC&YLQbC#<*TA&5^gAcyv0EF!ip|+(m2Kz}CUU-Fux63;
jvVXaBGrY#ID3eNFT<I5^%auq5Fn?Y9aTY!rosj(j<eKLf

literal 0
HcmV?d00001

-- 
2.25.1.481.gfbce0eb801-goog

