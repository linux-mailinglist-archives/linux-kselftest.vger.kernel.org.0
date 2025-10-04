Return-Path: <linux-kselftest+bounces-42773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C1BB92D4
	for <lists+linux-kselftest@lfdr.de>; Sun, 05 Oct 2025 01:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CBD19A0501
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B34248898;
	Sat,  4 Oct 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njbcudxe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B62417C5
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621814; cv=none; b=TCowGnMILrVPKaAKkPDjc5KN0GqEqF7NocWdBUrraFjT0arsfTpI2mnRY4NN+85EPasFhSf/8j1iwUnUcecsNO4EyLow+bqkwCKtqNdwdtZq1gGSUoZ3fww5CRtoEthKSkaBnxMsXwZ49/pzPRmGG0K85B6z3rLnna3cjAmbIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621814; c=relaxed/simple;
	bh=WtMoMSeSoC/p1iM5dJqIjQogzGbr6NxYCI0Aqh4nLC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMHbTwi3J8Xcq35pmpn0+ZoAuZsp/c4USbyNuh7f9j3Y4vDiHPijFcUroNHZVqtZS8rDqbiemAnKRByf+5Hqp6/IETLau+kLUSum5YioNShTkwAuNKQdNa3oOiKZw9ZxAqEfsNrXQa0k+ntREF9HEhr4bulcH/UOgWHFDQEc8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Njbcudxe; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-799572d92b0so33366726d6.3
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Oct 2025 16:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621811; x=1760226611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=269GcBnSB1zX6TbhiOc5c+3UO/jzniuzx6nJANrBz9Q=;
        b=NjbcudxeOa81OotuJg3GZWFzjf0x/Kw5vUjfhuzbdoPzYXmguL0ywLnbDEsA4skWsf
         Icc6uveLUU0dNrJza9D9b+feLVUN06EzWGyQvh9mq4l/sqysudzQHOESFCJyvUxQQyAM
         lIcPPgIfWw/YdlBxfJKJXdWXKKpdndH6/M/RRL4pQg0dVdYYfDMFABtZqIDqB+3fY25O
         43bYwax4blSW5gCzwXxjeGxBc6ZRcDq+tSoSrfaF88/MkdWcliBhMqVpLpHAxRfhFedl
         hy1mnexFsq3mJ05WZaNcLqyD5CGZIP+mahBCSkjsOoJ/9smmyAZjYoorq0/LHaI+50fR
         HpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621811; x=1760226611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=269GcBnSB1zX6TbhiOc5c+3UO/jzniuzx6nJANrBz9Q=;
        b=o3YrasOyHxmIAlamlpfDQvq0b/zq0tx9m0YAJEvFfhI5a6fx5x0JnRTjerOErWs/VZ
         f2jDhux0gVRU4cVGcPq4pC9h3QQknagRdOiI02Bju6t6vjp1pFehFXAoMMFjOPkTI6PP
         JW+/XZtL6LKVvAH/nGEWx0bo+dvgWI8ENdR38rWO4FNFdIHScpuSvQquByNy/M002iKB
         pCZbtnPA1De1e+E7ggULZhY96qSwmFaK/9seeUoB/YmMIP8kAkqR7ShLg/Op1LmUB9OR
         xAod90aM08+xvlmFvcdKgdF+jevG8NjJU7KiaNYZUgIWgrrb4g9w5azWUvHx2ykcG7E4
         eC/g==
X-Forwarded-Encrypted: i=1; AJvYcCV3cmvf+QLoBC64HOVtwSR+OCOJ8iJ517VXwwx3LlhaZMyPk4eIbA1zu1Zl6KasLPdXYmrTYqrS8XUUEPuCZQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/5pSjJfQnzSNoXBEP2DTTw+NsbLVUpBpwu+53KgrHz03/+9L
	qtjxjHDkDuArZZbLxRYcnd8odMC+GiZKYwBG41VrnKQ0yS9yfZ0PZ48L
X-Gm-Gg: ASbGncsKoiU97Ziuug9X6oVB5nqslcgpr2z5AqQi8Wsag4l/WXYLtpRD7GFG518xtk5
	nwNZbPdpYKQiRwQ9xXiht/czXk6TagHXfmhmVvt2zs89I6LaLCPJNENz2RE5d+nmk9kdialOLmg
	70TdoA3LqceJQ7/0uRq8zh9nVmjxq0qtdoJ36ItILjjUxudjuRI1Yd9PQ163lJxBs2nwlV6jhnp
	TVHCw+txl4JZhIie2uekMToV1ro3noxU9ZpmlZhDJIm/dTRwyFfnFt5OcAB4oQ7J8gdrVFPiU81
	F8RZD2IS0e3UkT6inTzTbr44XPIQzuGx577UoAFZg8zoHAE0e3WTpFB+rHlI+rx9IK1ZNZkCgz7
	jxqN3YpejJZIYl9uY7myhR/UeWNfiKbAbyye5iJKjsDMfiWhFoixkR90bxMZ+cZjHvgOrMsGLN+
	MvJ41ei6pwHHW7/Qh26APVYXevcw==
X-Google-Smtp-Source: AGHT+IFqA7ZihIIUPOeSck5FmUA+oqsyZIZgooAId33OvSZXAT8OnHtHAdLcjnfGO2sYAio1j2XwAQ==
X-Received: by 2002:a05:6214:4009:b0:7c6:bbaf:11b4 with SMTP id 6a1803df08f44-879dc882898mr106998946d6.54.1759621811013;
        Sat, 04 Oct 2025 16:50:11 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:10 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 0/5] tracing: fprobe: list-style filters,
Date: Sun,  5 Oct 2025 08:46:54 +0900
Message-ID: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to extend fprobe with list-style filters and a clear
entry/exist qualifier. Users can now specify a comma-separated symbol
list with ! exclusions, and use a spec-level suffix to select probe
type:

- funcA*, !funcAB, funcC -> entry probes
- funcA*, !funcAB, funcC:entry -> explicit entry
- funcA*, !funcAB, funcC:exit -> return/exit across the whole list

For compatibility, %return remains supported for single, literal
symbols. When a list or wildcard is used, an explicit [GROUP/EVENT is
required and autogeneration is disabled. Autogen names are kept for
single-symbol specs, with wildcard sanitization. For list/wildcard forms
we set ctx->funcname = NULL so BTF lookups are not attempted.

The series moves parsing to the parse path, documents the new syntax,
and adds selftests that accept valid list cases and reject empty tokens,
stray commas, and %return mixed with lists or wildcards. Selftests also
verify enable/disable flow and that entry+exit on the same set do not
double-count attached functions.

Help wanted: This is my first time contributing ftrace selftests. I
would appreciate comments and recommendations on test structure and
coverage.

Basic coverage is included, but this likely needs broader testing across
architectures. Feedback and additional test ideas are welcome.

Changes since v2:
- Introduce spec-level: :entry/:exit; reject %return with
  lists/wildcards
- Require explict [GROUP/]EVENT for list/wildcard; keep autogen only for
  single literal.
- Sanitize autogen names for single-symbol wildcards
- Set ctx->funcname = NULL for list/wildcard to bypass BTF
- Move list parsing out of __register_trace_fprobe() and into the parse
  path
- Update docs and tracefs README and add dynevent selftests for
  accept/reject and enable/disable flow

Link: https://lore.kernel.org/lkml/20250904103219.f4937968362bfff1ecd3f004@kernel.org/

Ryan Chung (5):
  docs: tracing: fprobe: document list filters and :entry/:exit
  tracing: fprobe: require explicit [GROUP/]EVENT for list/wildcard
  tracing: fprobe: support comma-separated symbols and :entry/:exit
  selftests/ftrace: dynevent: add reject cases for list/:entry/:exit
  selftests/ftrace: dynevent: add reject cases

 Documentation/trace/fprobetrace.rst           |  27 +-
 kernel/trace/trace.c                          |   3 +-
 kernel/trace/trace_fprobe.c                   | 247 ++++++++++++++----
 .../test.d/dynevent/add_remove_fprobe.tc      | 121 +++++++++
 .../test.d/dynevent/fprobe_syntax_errors.tc   |  13 +
 5 files changed, 349 insertions(+), 62 deletions(-)

-- 
2.43.0


