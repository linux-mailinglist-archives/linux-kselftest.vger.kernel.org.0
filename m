Return-Path: <linux-kselftest+bounces-25384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB0A22329
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681063A4BCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006671E1C3A;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN8X7ixM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63011E04BE;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172365; cv=none; b=mls5JlNtTbo+QNGORbl+3mDIlZf+lAEfCB9RAHU7nucjyxZCnXblWOnxxjO6HnZxk31/MzSI+Sdqv/Mkl23V9aThHSgNIcViKxQP1kSxIOZc0uh5j/oCF4WEVxF/bolHMnzoNMKKKeJ3mK9/3dP++i8YjXyZ0Xq/w6jNWtIQOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172365; c=relaxed/simple;
	bh=tm9z92Tyd3NRl4GzuFEN85tCt2NQbLxHfOBfSXqmLqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVCzvzkzA/cYXAbqGKPJbwXg0ny2DRj091TqHYcw3s9Jzr9L8JqAzdkswSS3qLXylloSBjRgFxjoDq+7l8fb64tRcYIbpdCyHhR5T6uJLnLC7ZzDB660uFIwgx6ihlkc66MjOTFt/DZFHCVKFFf3Oi9kMNiVe7S/qODKrRwY8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN8X7ixM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAA6C4CEE4;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738172365;
	bh=tm9z92Tyd3NRl4GzuFEN85tCt2NQbLxHfOBfSXqmLqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cN8X7ixMMDSVpTaeIMp29MOxLREgALMK2u9F4VlYyFaobmQu5QdG/L0XuG1tEr40p
	 YoPVkZiOo4cjemjzj1JoyGHTPf+uf5XqJZdiDz5+rYvwP9uF36oIZgQI8hp/YADmbx
	 UN2OqCDhvtU+QQG0pJ+l+07jLLzCSUpRuuJyHk+27N0kGd4MEhOkp1Fq0zIpxQ3w3J
	 tHMlIO7AjOvol/Wer+MeSiKYyir89/hVoNggaP/tgRwz+tQBrOOAVAEGBxVCl49PY9
	 dijr4MgzmzxItduwnvhwCKfQtWsVt2EGWMEerIRAJik8PlZXCdULZov9OZCdkIJO2B
	 9Z/WX3XqPSvcw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tdC26-00000004SdU-3ekY;
	Wed, 29 Jan 2025 18:39:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Alexei Starovoitov <mchehab+huawei@kernel.org>,
	Andrii Nakryiko <mchehab+huawei@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <mchehab+huawei@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <mchehab+huawei@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <mchehab+huawei@kernel.org>,
	Song Liu <mchehab+huawei@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/6] tools: selftests/bpf: test_bpftool_synctypes: escape raw symbols
Date: Wed, 29 Jan 2025 18:39:07 +0100
Message-ID: <12d8c07cc7bcea017f67774741f9a59d04c2f20d.1738171937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171937.git.mchehab+huawei@kernel.org>
References: <cover.1738171937.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Modern Python versions complain about usage of "\" inside normal
strings, as they should use r-string notation.

Change the annotations there to avoid such warnings:

	tools/testing/selftests/bpf/test_bpftool_synctypes.py:319: SyntaxWarning: invalid escape sequence '\w' pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../selftests/bpf/test_bpftool_synctypes.py   | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index 0ed67b6b31dd..81f286991012 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -66,7 +66,7 @@ class ArrayParser(BlockParser):
 
     def __init__(self, reader, array_name):
         self.array_name = array_name
-        self.start_marker = re.compile(f'(static )?const bool {self.array_name}\[.*\] = {{\n')
+        self.start_marker = re.compile(fr'(static )?const bool {self.array_name}\[.*\] = {{\n')
         super().__init__(reader)
 
     def search_block(self):
@@ -80,7 +80,7 @@ class ArrayParser(BlockParser):
         Parse a block and return data as a dictionary. Items to extract must be
         on separate lines in the file.
         """
-        pattern = re.compile('\[(BPF_\w*)\]\s*= (true|false),?$')
+        pattern = re.compile(r'\[(BPF_\w*)\]\s*= (true|false),?$')
         entries = set()
         while True:
             line = self.reader.readline()
@@ -177,9 +177,9 @@ class FileExtractor(object):
 
         @enum_name: name of the enum to parse
         """
-        start_marker = re.compile(f'enum {enum_name} {{\n')
-        pattern = re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
-        end_marker = re.compile('^};')
+        start_marker = re.compile(fr'enum {enum_name} {{\n')
+        pattern = re.compile(r'^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
+        end_marker = re.compile(r'^};')
         parser = BlockParser(self.reader)
         parser.search_block(start_marker)
         return parser.parse(pattern, end_marker)
@@ -226,8 +226,8 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'\*{block_name}\* := {{')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        start_marker = re.compile(fr'\*{block_name}\* := {{')
+        pattern = re.compile(r'\*\*([\w/-]+)\*\*')
         end_marker = re.compile('}\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -245,8 +245,8 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'"\s*{block_name} := {{')
-        pattern = re.compile('([\w/]+) [|}]')
+        start_marker = re.compile(fr'"\s*{block_name} := {{')
+        pattern = re.compile(r'([\w/]+) [|}]')
         end_marker = re.compile('}')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -264,8 +264,8 @@ class FileExtractor(object):
 
         @macro: macro starting the block, 'HELP_SPEC_OPTIONS' in the example
         """
-        start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]])')
+        start_marker = re.compile(fr'"\s*{macro}\s*" [|}}]')
+        pattern = re.compile(r'([\w-]+) ?(?:\||}[ }\]])')
         end_marker = re.compile('}\\\\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -284,7 +284,7 @@ class FileExtractor(object):
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
         start_marker = re.compile(f'local {block_name}=\'')
-        pattern = re.compile('(?:.*=\')?([\w/]+)')
+        pattern = re.compile(r'(?:.*=\')?([\w/]+)')
         end_marker = re.compile('\'$')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -316,7 +316,7 @@ class MainHeaderFileExtractor(SourceFileExtractor):
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
         start_marker = re.compile(f'"OPTIONS :=')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')
+        pattern = re.compile(r'([\w-]+) ?(?:\||}[ }\]"])')
         end_marker = re.compile('#define')
 
         parser = InlineListParser(self.reader)
@@ -338,8 +338,8 @@ class ManSubstitutionsExtractor(SourceFileExtractor):
 
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
-        start_marker = re.compile('\|COMMON_OPTIONS\| replace:: {')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        start_marker = re.compile(r'\|COMMON_OPTIONS\| replace:: {')
+        pattern = re.compile(r'\*\*([\w/-]+)\*\*')
         end_marker = re.compile('}$')
 
         parser = InlineListParser(self.reader)
-- 
2.48.1


